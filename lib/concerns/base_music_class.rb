class BaseMusicClass
	def self.create(name)
		self.new(name).tap{|new_self| new_self.save}
	end

	def self.destroy_all
		self.all.clear
	end 

	def save
		self.class.all << self 
	end
end
