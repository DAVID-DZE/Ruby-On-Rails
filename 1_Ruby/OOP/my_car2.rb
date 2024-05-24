module Towable
  def can_tow?(pounds)
    pounds < 2000
  end
end

class Vehicle
  attr_accessor :color
  attr_reader :model, :year
  @@number_of_vehicles = 0

  def self.number_of_vehicles
    puts "There are #{@@number_of_vehicles} created"
  end

  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
    @@number_of_vehicles+=1
  end

  def self.gas_mileage(gallons, miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def speed_up(amount)
    @speed += amount
    puts "You speed up by #{amount} mph."
  end

  def brake(amount)
    @speed -= amount
    puts "You slow down by #{amount} mph."
  end

  def shut_off
    @speed = 0
    puts "You shut off the car."
  end

  def spray_paint(new_color)
    self.color = new_color
    puts "The car is now #{color}."
  end

  def age
    "Your #{self.model} is #{years_old} years old"
  end

  private

  def years_old
    Time.now.year - self.year
  end

end

class MyCar < Vehicle
  def to_s
      "My car is a #{color} #{@model} made in #{year}"
  end

  WHEEL_COUNT = 4
end

class MyTruck < Vehicle
  include Towable
  def to_s
    "My Truck is a #{color} #{@model} made in #{year}"
  end

  WHEEL_COUNT = 18
end

car = MyCar.new(2015, "red", "Toyota")
car.speed_up(20)
car.brake(10)
car.shut_off
car.color = "blue"
puts car.color
puts car.year
car.spray_paint("green")
MyCar.gas_mileage(8, 100)
puts car.to_s

truck = MyTruck.new(2010, "black", "Ford")
Vehicle.number_of_vehicles

puts MyCar.ancestors
puts MyTruck.ancestors
puts Vehicle.ancestors

puts car.age
