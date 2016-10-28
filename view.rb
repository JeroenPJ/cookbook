require_relative 'recipe'
require_relative 'cookbook'

class View
  def initialize(cookbook)
    @cookbook = cookbook
  end

  def create
    puts "Enter the name:"
    name = gets.chomp
    puts "Enter the description:"
    description = gets.chomp
    puts "Enter the cooking time (in minutes):"
    cooking_time = gets.chomp.to_i
    puts "Enter the difficulty (1, 2, or 3): "
    difficulty = gets.chomp.to_i
    Recipe.new(name, description, cooking_time, difficulty)
  end

  def open
    recipe_id = get_recipe_id
    recipe = @cookbook.recipes[recipe_id]
    puts recipe.name.upcase
    puts "Cooking time: #{recipe.cooking_time}"
    puts "Difficulty: #{recipe.difficulty}"
    puts ""
    puts recipe.description
  end

  def get_ingredient
    puts "Import recipes for which ingredient?"
    ingredient = gets.chomp.downcase
    puts "Looking for #{ingredient} on Jamie Oliver..."
    ingredient
  end

  def list_recipes_from_hash(recipes)
    puts "#{recipes.size} results found:"
    i = 1
    recipes.each do |key, val|
      puts "#{i}. #{key}"
      i += 1
    end
    puts ""
  end

  def recipe_id_from_import
    puts "Please type a number to choose which recipe to import"
    recipe_id = gets.chomp.to_i - 1
    puts ""
    recipe_id
  end

  def get_recipe_id
    list
    puts ""
    puts "Please enter the recipe id: "
    gets.chomp.to_i - 1
  end

  def list
    @cookbook.recipes.each_with_index do |recipe, index|
      done_symbol = recipe.done ? "[x]" : "[ ]"
      puts "#{index + 1}. #{done_symbol} #{recipe.name.capitalize}  (#{recipe.cooking_time} min)"
    end
  end
end
