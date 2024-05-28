# frozen_string_literal: true

def caesar_cipher(str, shift)
  str.chars.map do |c|
    ascii = c.ord
    if ascii.between?('a'.ord, 'z'.ord)
      (((ascii - 'a'.ord + shift) % 26) + 'a'.ord).chr
    elsif ascii.between?('A'.ord, 'Z'.ord)
      (((ascii - 'A'.ord + shift) % 26) + 'A'.ord).chr
    else
      c
    end
  end.join
end

p caesar_cipher('What a string!', 5)
