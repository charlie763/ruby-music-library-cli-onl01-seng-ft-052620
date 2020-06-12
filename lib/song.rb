class Song < BaseMusicClass
	extend Concerns::Findable
	extend Concerns::FileNameParser

	@@all = []

	attr_accessor :name
	attr_reader :artist, :genre

	def initialize(name, artist=nil, genre=nil)
		@name = name
		self.artist = artist if artist
		self.genre = genre if genre
	end

	def self.all
		@@all
	end

	def artist=(artist)
		@artist = artist 
		artist.add_song(self)
	end

	def genre=(genre)
		@genre = genre 
		genre.songs << self unless genre.songs.include?(self)
	end

	def self.new_from_filename(filename)
		#expect filename format to be "Thundercat - For Love I Come - dance.mp3"
		file_hash = f_hash(filename)
		artist = Artist.find_or_create_by_name(file_hash[:artist_name])
		genre = Genre.find_or_create_by_name(file_hash[:genre_name])
		Song.new(file_hash[:song_name], artist, genre) 
	end	

	def self.create_from_filename(filename)
		self.new_from_filename(filename).tap{|new_song| new_song.save}
	end

end