class Recipe
  attr_reader :name, :description, :cooking_time, :done, :difficulty
  def initialize(name, description, cooking_time, done = false, difficulty)
    @name = name
    @description = description
    @cooking_time = cooking_time
    @done = done
    @difficulty = difficulty
  end

  def mark_as_done
    @done = true
  end
end
