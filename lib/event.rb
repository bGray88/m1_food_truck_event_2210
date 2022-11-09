# frozen_string_literal: true

# This is the Event Class
class Event

  attr_reader :name,
              :food_trucks

  def initialize(name)
    @name           = name
    @food_trucks    = []
  end

  def add_food_truck(truck)
    @food_trucks.push(truck)
  end

  def food_truck_names
    @food_trucks.map { |truck| truck.name }
  end

  def food_trucks_that_sell(item)
    @food_trucks.select { |truck| truck.item?(item) == true }
  end

  def list_all_items_sold
    @food_trucks.flat_map { |truck| truck.list_items_sold }.uniq
  end

  def total_quantity_item(item)
    @food_trucks.map do |truck|
      truck.check_stock(item)
    end.sum
  end

  def oversold_items
    list_all_items_sold.select{ |item| (food_trucks_that_sell(item).length > 1) && (total_quantity_item(item) > 50) }
  end
end
