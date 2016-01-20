class Zip
	#convenient method for access to client in console
	def self.mongo_client
		Mongoid::Clients.default
	end

	#comvenient method for access to zips collection
	def self.collection
		self.mongo_client['zips']
	end
end