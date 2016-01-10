class User < ActiveRecord::Base
	has_one(:profile, dependent: :destroy)
	has_many(:todo_lists, dependent: :destroy)
	has_many(:todo_items, through: :todo_lists, source: :todo_items, dependent: :destroy)
	validates(:username, presence: true)

	def get_completed_count
		count = 0
		items = todo_items
		items.each do |item|
			if item.completed
				count += 1
			end
		end
		return count
	end
end
