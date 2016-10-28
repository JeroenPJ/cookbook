require_relative 'view'
require_relative 'parsing'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new(@cookbook)
    @parser = Parsing.new(@view)
  end

  def list
    @view.list
  end

  def open
    @view.open
  end

  def create
    @cookbook.add_recipe(@view.create)
  end

  def destroy
    @cookbook.remove_recipe(@view.get_recipe_id)
  end

  def import
    # ask for keyword
    keyword = @view.get_ingredient
    recipe_data = @parser.recipes_from_html(keyword)

    @cookbook.add_recipe(Recipe.new(recipe_data[0], recipe_data[1],
                                    recipe_data[2], recipe_data[3]))
  end

  def mark_as_done
    recipe_id = @view.get_recipe_id
    @cookbook.mark_as_done(recipe_id)
  end
end
