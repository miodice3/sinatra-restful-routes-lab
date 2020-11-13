require 'pry'
class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    #binding.pry
    @recipes = Recipe.create(params)
    redirect to "/recipes/#{@recipes.id}"
  end

  get '/recipes/:id' do
    
    @recipes = Recipe.find_by(id: params[:id])
    #binding.pry
    if @recipes
      erb :show
    else
      "whoops that recipe doesnt exist!"
    end
  end

  get '/recipes/:id/edit' do
    @recipes = Recipe.find_by(id: params[:id])
    #binding.pry
    if @recipes
      erb :edit
    else
      "whoops that recipe doesnt exist!"
    end
  end

  patch '/recipes/:id' do
    #binding.pry
    recipe=Recipe.find_by_id(params[:id])
    recipe.update(params[:update])
    #binding.pry

    redirect "/recipes/#{recipe.id}"
  end


  get '/recipes' do
    @recipes = Recipe.all
    #binding.pry
    erb :index
  end

  delete '/recipes/:id' do
    @recipes = Recipe.find_by(id: params[:id])
    #binding.pry
    @recipes.destroy
    redirect "/recipes"
  end

end
