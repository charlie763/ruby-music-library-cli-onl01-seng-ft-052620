class Genre < BaseMusicClass
	extend Concerns::Findable

	@@all = []

	attr_accessor :name, :songs

	def initialize(name)
		@name = name
		@songs = []
	end

	def self.all
		@@all
	end


	def artists
		self.songs.map{|song| song.artist}.uniq
	end


end