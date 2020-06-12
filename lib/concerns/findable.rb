module Concerns
	module Findable
		def find_by_name(name)
			self.all.find{|music_obj| music_obj.name == name}
		end

		def find_or_create_by_name(name)
			music_obj = self.find_by_name(name)
			music_obj ? music_obj : self.create(name)
		end
	end

	module FileNameParser
		def f_hash(filename)
			ary = filename.split(" - ")
			{artist_name: ary[0], song_name: ary[1], genre_name: ary[2].delete_suffix('.mp3')}
		end
	end
end