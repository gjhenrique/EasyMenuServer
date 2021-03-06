# frozen_string_literal: true

module Parser
  module ParserHelper
    def build_meal(list, procs = {})
      meals_dishes = chunk_by_condition(list, &procs[:meal_condition])
      build_meals_from_list(meals_dishes, procs)
    end

    def chunk_by_condition(list, &meal_condition)
      raise ArgumentError, 'meal_condition proc cannot be nil' if meal_condition.nil?

      meals = []
      dishes = []
      list.chunk(&meal_condition).each do |is_meal, values|
        is_meal ? meals.push(values[0]) : dishes.push(values)
      end
      meals.zip dishes
    end

    def build_meals_from_list(list_meals, procs = {})
      raise ArgumentError, 'dish_builder proc cannot be nil' if procs[:dish_builder].nil?
      raise ArgumentError, 'meal_builder proc cannot be nil' if procs[:meal_builder].nil?

      list_meals.map do |meals|
        meal = procs[:meal_builder].call meals[0]
        meal.dishes = meals[1].flat_map { |dish| procs[:dish_builder].call(dish) }.compact
        meal
      end
    end
  end
end
