class Artist < BaseMusicClass
	extend Concerns::Findable

	@@all = []

	attr_accessor :name
	attr_reader :songs

	def initialize(name)
		@name = name
		@songs = []  
	end

	def self.all
		@@all
	end


	def add_song(song)
		song.artist = self unless song.artist
		self.songs << song unless self.songs.include?(song)
	end

	def genres
		self.songs.map{|song| song.genre}.uniq
	end


end