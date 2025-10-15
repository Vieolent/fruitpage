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
  query = params[:q]
  if query && !query.empty?
    @fruits = db.execute("SELECT * FROM fruits WHERE name LIKE ?", "%#{query}%")
  else
    @fruits = db.execute("SELECT * FROM fruits")
  end
  slim(:"fruits/index")
end

get('/new') do
  slim(:"fruits/new")
end



post('/fruits/:id/delete') do
  #koppla till db
  db = SQLite3::Database.new('db/fruits.db')
  #extrahera id från sökväg för att få rätt frukt
  denna_ska_bort = params[:id].to_i
  #ta bort från db
  db.execute("DELETE FROM fruits WHERE id = ?",denna_ska_bort)
  redirect('/fruits')
end

post('/fruits') do
  new_fruit = params[:new_fruit]
  amount = params[:amount].to_i
  db = SQLite3::Database.new('db/fruits.db')
  db.execute("INSERT INTO fruits (name, amount) VALUES (?,?)",[new_fruit,amount])
  redirect('/fruits')
end

get("/fruits/:id/edit") do 
id = params[:id].to_i

  db = SQLite3::Database.new("db/fruits.db")
  db.results_as_hash = true
  @selected_fruit = db.execute("SELECT * FROM fruits WHERE id=?", id).first
  slim(:"fruits/edit")
end

post('/fruits/:id/update') do

  db = SQLite3::Database.new('db/fruits.db')
  id = params[:id].to_i
  name = params[:name]
  amount = params[:amount].to_i
  db.execute("UPDATE fruits SET name=?, amount=? WHERE id=?", [name,amount,id])

  redirect('/fruits')
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