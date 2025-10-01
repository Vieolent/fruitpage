require 'sinatra'
require 'slim'
require 'sinatra/reloader'
require 'sqlite3'

get('/fruits') do
  #En koppling till db (magi)
  db = SQLite3::Database.new("db/fruits.db")

  #Ge oss hash istället för arrayer
  db.results_as_hash = true

  #Använd sql för att prata med db samt hämta allt från db
  @fruits = db.execute("SELECT * FROM fruits")
  p @fruits
  slim(:index)
end

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

get('/fighter/:pokemon') do
  pokemon = params[:pokemon]
  if pokemon == "charizard"
    move = "fireball"
    rating = " 10/10"
  else
    move = "scratch"
    rating = "n ...interesting"
  end
  @chosen = {
  "name" => pokemon,
  "primary" => move,
  "rating" => rating
  }
  slim(:fighter)
end

get('/fruit2') do
  @fruits = [
  {
    "name" => "Banana",
    "rating" => "8/10",
    "accessibility" => "Easy"
  },
  {
    "name" => "Apple",
    "rating" => "7/10",
    "accessibility" => "Easy"
  },
  {
    "name" => "Mango",
    "rating" => "9/10",
    "accessibility" => "Medium"
  }
  ]
  slim(:fruit)
end