class MusicLibraryController
	include Concerns::FileNameParser

	attr_accessor :music_importer

	def initialize(path = './db/mp3s')
		self.music_importer = MusicImporter.new(path)
		self.music_importer.import
	end

	def call
		input = nil
		while input != "exit" do
			puts "Welcome to your music library!"
			puts "To list all of your songs, enter 'list songs'."
			puts "To list all of the artists in your library, enter 'list artists'."
			puts "To list all of the genres in your library, enter 'list genres'."
			puts "To list all of the songs by a particular artist, enter 'list artist'."
			puts "To list all of the songs of a particular genre, enter 'list genre'."
			puts "To play a song, enter 'play song'."
			puts "To quit, type 'exit'."
			puts "What would you like to do?"

			input = gets.chomp

			case input
				when "list songs"
					self.list_songs
				when "list artists"
					self.list_artists
				when "list genres"
					self.list_genres
				when "list artist"
					self.list_songs_by_artist
				when "list genre"	
					self.list_songs_by_genre
				when "play song"
					self.play_song
			end
		end
	end

	def alphabetized_list_by(category)
		self.music_importer.files.sort{|a,b| f_hash(a)[category] <=> f_hash(b)[category]} 
	end

	def list_songs
		self.alphabetized_list_by(:song_name).each.with_index(1) do |filename, i|
			puts "#{i}. #{filename.delete_suffix('.mp3')}"
		end
	end

	def list_artists
		artist_names = Artist.all.map{|artist| artist.name}
		artist_names.sort.each.with_index(1){|artist, i| puts "#{i}. #{artist}"}
	end

	def list_genres
		print_list = self.alphabetized_list_by(:genre_name).each.with_index(1).map do |filename, i|
			"#{f_hash(filename)[:genre_name]}"
		end
		print_list.uniq.each.with_index(1){|genre, i| puts "#{i}. #{genre}"}
	end

	def list_songs_by_artist
		puts "Please enter the name of an artist:"
		artist = Artist.find_or_create_by_name(gets.chomp)
		alphabetized_list = artist.songs.sort{|a,b| a.name <=> b.name}
		alphabetized_list.each.with_index(1){|song, i|puts "#{i}. #{song.name} - #{song.genre.name}" }
	end

	def list_songs_by_genre
		puts "Please enter the name of a genre:"
		genre = Genre.find_or_create_by_name(gets.chomp)
		alphabetized_list = genre.songs.sort{|a,b| a.name <=> b.name}
		alphabetized_list.each.with_index(1){|song, i|puts "#{i}. #{song.artist.name} - #{song.name}" }
	end

	def play_song
		puts "Which song number would you like to play?"
		song_number = gets.chomp.to_i
		alphabetized_songs = Song.all.sort{|a,b| a.name <=> b.name}
		chosen_song = alphabetized_songs[song_number - 1]
		if song_number >= 1 && song_number <= alphabetized_songs.length
			puts "Playing #{chosen_song.name} by #{chosen_song.artist.name}"
		end
	end
end