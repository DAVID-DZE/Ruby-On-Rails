require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'date'

def registration_info(reg_date)
  time = DateTime.strptime(reg_date, '%m/%d/%y %H:%M')

  {hour: time.hour, wday: time.wday}
end

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def clean_phone_number(phone_number)
  digits = phone_number.to_s.gsub(/\D/, '')

  if digits.length < 10 || digits.length > 11 || (digits.length == 11 && digits[0] != '1')
    return 'Bad number'
  end

  digits = digits.length == 11 ? digits[1..-1] : digits

  digits
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

hours = Hash.new(0)
days = Hash.new(0)

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone_number = clean_phone_number(row[:homephone])
  reg_date = row[:regdate]
  reg_info = registration_info(row[:regdate])
  hour = reg_info[:hour]
  wday = reg_info[:wday]
  hours[hour] +=1
  days[wday] +=1

  legislators = legislators_by_zipcode(zipcode)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id,form_letter)
end

def day_of_week(day_number)
  Date::DAYNAMES[day_number]
end

peak_hours = hours.sort_by { |hour, count| -count }.map { |hour, count| hour }
peak_days = days.sort_by { |day, count| -count }.map { |day, count| day_of_week(day) }

puts "Peak registration hours: #{peak_hours}"
puts "Peak registration days: #{peak_days}"
