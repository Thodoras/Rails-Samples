class Zip
	#convenient method for access to client in console
	def self.mongo_client
		Mongoid::Clients.default
	end

	#comvenient method for access to zips collection
	def self.collection
		self.mongo_client['zips']
	end

	def self.all(prototype={}, sort={:population=>1}, offset=0, limit=100)

		tmp = {} #hash needs to stay in stable order provided
	    sort.each {|k,v| 
	      k = k.to_sym==:population ? :pop : k.to_sym
	      tmp[k] = v  if [:city, :state, :pop].include?(k)
	    }
	    sort=tmp

    	prototype=prototype.symbolize_keys.slice(:city, :state) if !prototype.nil?

		result=collection.find(prototype)
       	  .projection({_id:true, city:true, state:true, pop:true})
          .sort(sort)
          .skip(offset)
    	result=result.limit(limit) if !limit.nil?
    	return result
	end

	def self.find
		doc=collection.find(:_id=>id)
            .projection({_id:true, city:true, state:true, pop:true})
            .first
    	return doc.nil? ? nil : Zip.new(doc)
	end

	def save
		self.class.collection.insert_one(_id:@id, city:@city, state:@state, pop:@population)
	end

	def update(updates)
		updates[:pop]=updates[:population]  if !updates[:population].nil?
    	updates.slice!(:city, :state, :pop) if !updates.nil?

    	self.class.collection
            .find(_id:@id)
            .update_one(:$set=>updates)
	end

	def destroy
		self.class.collection
            .find(_id:@id)
            .delete_one   
	end
end