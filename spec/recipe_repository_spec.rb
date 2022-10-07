require 'recipe_repository'

def reset_recipes_table
  seed_sql = File.read('spec/seeds_recipes.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'recipes_directory' })
  connection.exec(seed_sql)
end

describe RecipeRepository do
  before(:each) do
    reset_recipes_table
  end

  it "returns all recipes" do
    repo = RecipeRepository.new

    recipes = repo.all

    expect(recipes.length).to eq 2
  end

  it "returns info on any recipes in all" do
    repo = RecipeRepository.new

    recipes = repo.all

    expect(recipes[0].id).to eq '1'
    expect(recipes[0].name).to eq 'Fish and Chips'
    expect(recipes[0].cooking_time).to eq '25'
    expect(recipes[0].rating).to eq '5'
  end

  it "finds and returns on recipe" do
    repo = RecipeRepository.new

    recipe = repo.find(1)

    expect(recipe.name).to eq 'Fish and Chips'
    expect(recipe.cooking_time).to eq '25'
    expect(recipe.rating).to eq '5'
  end

  it "finds and returns on recipe (2)" do
    repo = RecipeRepository.new

    recipe = repo.find(2)

    expect(recipe.name).to eq 'Burger'
    expect(recipe.cooking_time).to eq '40'
    expect(recipe.rating).to eq '4'
  end
end
