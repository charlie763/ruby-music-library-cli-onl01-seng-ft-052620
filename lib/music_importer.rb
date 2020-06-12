class MusicImporter
	attr_accessor :path

	def initialize(path)
		@path = path
	end

	def files
		#Dir[path + "/*.mp3"].map{|file| file.delete_prefix(path + "/")}
		#Dir.entries(path).select{|file| file[-3..-1] == "mp3"}
		Dir.entries(path).grep(/\.mp3/)
	end

	def import
		self.files.each{|filename| Song.create_from_filename(filename)}
	end
end