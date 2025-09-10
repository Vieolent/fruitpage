require 'sinatra'
require 'slim'
require 'sinatra/reloader'

get('/') do
 return "startsida"
end

get('/about') do
  @shiny = 5
  slim(:about)
end

get('/shady') do
  slim(:shady)
end

get('/choose/:fruit') do
  @fruit = params[:fruit]
  slim(:printer)
end