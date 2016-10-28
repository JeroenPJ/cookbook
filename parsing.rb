require 'nokogiri'
require 'open-uri'

class Parsing
  def initialize(view)
    @view = view
  end

  def recipes_from_html(keyword)
    url = "http://www.jamieoliver.com/search/?s=#{keyword}"
    doc = Nokogiri::HTML(open(url), nil, 'utf-8')
    recipe_names = []

    doc.search('.result').each do |element|
      recipe_names << element.search('h2').text
    end

    @view.list_recipes_from_hash(recipe_names)
    recipe_id = @view.recipe_id_from_import

    i = 0

    doc.search('.result').each do |element|
      if i == recipe_id
        cooking_time = get_cooking_time(element)
        name = element.search('h2').text
        difficulty = get_difficulty(element)

        recipe_url = element.search('a').attr('href')

        doc = Nokogiri::HTML(open(recipe_url), nil, 'utf-8')
        description = doc.search('.method-p').first.text

        return [name, description, cooking_time, difficulty]
      else
        i += 1
      end
    end
  end

  private

  def get_difficulty(element)
    difficulty_element = element.search('.recipe-meta > .difficulty')
      difficulty_text = difficulty_element.text unless difficulty_element.nil?
      case difficulty_text
      when "super easy"
        return 1
      when "not too tricky"
        return 2
      when "showing off"
        return 3
      else
        return 2
      end
  end

  def get_cooking_time(element)
    cooking_time_element = element.search('.recipe-meta > .time')
    unless cooking_time_element.nil?
      cooking_time_text = cooking_time_element.text
      cooking_time_match = cooking_time_text.match(/(\d*H)?\s?(\d*)M?/)
      cooking_time_match[1].delete("H").to_i * 60 + cooking_time_match[2].to_i
    else
      nil
    end
  end
end
