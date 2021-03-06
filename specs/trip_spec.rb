require_relative 'spec_helper'
require 'pry'

describe "Trip class" do

  describe "initialize" do
    before do
      # start_time = Time.parse('2015-05-20T12:14:00+00:00')
      # end_time = start_time + 25 * 60 # 25 minutes
      start_time = '2015-05-20T12:14:00+00:00'
      end_time = '2015-05-20T12:39:00+00:00'
      @trip_data = {
        id: 8,
        driver: RideShare::Driver.new(id: 3, name: "Lovelace", vin: "12345678912345678"),
        passenger: RideShare::Passenger.new(id: 1, name: "Ada", phone: "412-432-7640"),
        start_time: start_time,
        end_time: end_time,
        cost: 23.45,
        rating: 3
      }
      @trip = RideShare::Trip.new(@trip_data)
    end

    it "is an instance of Trip" do
      @trip.must_be_kind_of RideShare::Trip
    end

    it "stores an instance of passenger" do
      @trip.passenger.must_be_kind_of RideShare::Passenger
    end

    it "stores an instance of driver" do
      @trip.driver.must_be_kind_of RideShare::Driver
    end

    it "raises an error for an invalid rating" do
      [-3, 0, 6].each do |rating|
        @trip_data[:rating] = rating
        proc {
          RideShare::Trip.new(@trip_data)
        }.must_raise ArgumentError
      end
    end

    it "returns trip duration" do
      @trip.trip_duration.must_be_kind_of Integer
      @trip.trip_duration.must_equal 25
    end

    it "raises an ArgumentError" do
      proc {
        @trip_data[:end_time] = '2015-05-20T12:00:00+00:00'
        RideShare::Trip.new(@trip_data).trip_duration}.must_raise ArgumentError
    end
  end
end
