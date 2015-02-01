require 'sinatra'
require 'json'
require 'sqlite3'
require 'pry'



set :public, File.dirname(__FILE__) + '/public'

db = SQLite3::Database.new "music.db"

#this method capitalizes data going into the database
def capitalize(x)
	array = x.split(" ")
	array.map! {|y| y.downcase.capitalize!}
	name = array.join(" ")
end



#INDEX.ERB PAGE
#all artists
get '/artists' do
	artists = db.execute("SELECT * FROM artists")
	erb :index, locals: {artists: artists}
end


#add an artist
post '/artist' do
	artist = capitalize(params["name"])
	db.execute("INSERT INTO artists(name) VALUES (?)", artist)
	redirect '/artists'
end


#delete an artist ands all of its sub albums and songs
delete '/artist/:id' do
	artist_id = params[:id].to_i
	db.execute("DELETE FROM artists WHERE id=(?)", artist_id)
	albums = db.execute("SELECT * FROM albums WHERE artist_id = (?)", artist_id)
	db.execute("DELETE FROM albums WHERE artist_id = (?)", artist_id)
	album_id = []
	albums.each{ |x| album_id.push(x[0]) }
	album_id.each{ |x| db.execute("DELETE FROM songs WHERE album_id = (?)", x)}
	redirect '/artists'
end

 


#ARTIST.ERB PAGE
#view single artist and their albums
get '/artist/:id' do
	artist = db.execute("SELECT * FROM artists WHERE id=(?)", params[:id].to_i)
	album_id = artist[0][0]
	albums = db.execute("SELECT * FROM albums WHERE artist_id=(?)", album_id.to_i)
	erb :artist, locals: {artist: artist, albums: albums}
end


#update artist name
put '/artist/:id' do
	artist = capitalize(params['newname'])
	db.execute("UPDATE artists SET name=(?) WHERE id=(?)", artist, params[:id].to_i)
	redirect '/artist/' + params[:id]
end


#add an album
post '/album' do
	album = capitalize(params["names"])
	artist_id = params["artist_id"]
	db.execute("INSERT INTO albums(names, artist_id) VALUES (?, ?)", album, artist_id)
	redirect '/artist/' + artist_id
end

#delete album and songs
delete '/album/:id' do
	album_id = params[:id].to_i
	artist_id = params["artist_id"]
	db.execute("DELETE FROM albums WHERE id=(?)", album_id)
	db.execute("DELETE FROM songs WHERE album_id = (?)", album_id)
	redirect '/artist/' + artist_id
end




#ALBUMS.ERB PAGE
#view single album and its songs
get '/album/:id' do
	album = db.execute("SELECT * FROM albums WHERE id=(?)", params[:id].to_i)
	song_id = album[0][0]
	songs = db.execute("SELECT * FROM songs WHERE album_id=(?)", song_id.to_i)
	artist_id = album[0][2]
	artist = db.execute("SELECT * FROM artists WHERE id = (?)", artist_id )
	erb :album, locals: {album: album, songs: songs, artist: artist}
end


#update album name
put '/album/:id' do
	name = capitalize(params["newname"])
	db.execute("UPDATE albums SET names=(?) WHERE id=(?)", name, params[:id].to_i)
	redirect '/album/' + params[:id]
end

#add a song
post '/song' do
	title = capitalize(params["title"])
	album_id = params["album_id"]
	db.execute("INSERT INTO songs(title, album_id) VALUES (?, ?)", title, album_id)
	redirect '/album/' + album_id
end

#update song name
put '/song/:id' do
	name = capitalize(params["newname"])
	album_id = params["album_id"]
	db.execute("UPDATE songs SET title=(?) WHERE id=(?)", name, params[:id].to_i)
	redirect '/album/' + album_id
end

#delete song
delete '/song/:id' do
	song_id = params[:id].to_i
	album_id = params["album_id"]
	db.execute("DELETE FROM songs WHERE id=(?)", song_id)
	redirect '/album/' + album_id
end




