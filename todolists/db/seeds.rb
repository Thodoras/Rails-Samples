# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)\


User.create!([
	{username: "Fiorina", password_digest: "123"},
	{username: "Trump", password_digest: "123"},
	{username: "Carson", password_digest: "123"},
	{username: "Clinton", password_digest: "123"}
])

Profile.create!([
	{gender: "female", birth_year: 1954, first_name: "Carly", last_name: "Fiorina"},
	{gender: "male", birth_year: 1946, first_name: "Donald", last_name: "Trump"},
	{gender: "male", birth_year: 1951, first_name: "Ben", last_name: "Carson"},
	{gender: "female", birth_year: 1947, first_name: "Hillary", last_name: "Clinton"}
])


users = User.all

users.each do |user|
	user.todo_lists.create!([
		{list_due_date: Date.today + 1.year}
	])
end

lists = TodoList.all

lists.each do |list|
	list.todo_items.create!([
		{due_date: Date.today + 1.year, title: "foo", description: "bar"},
		{due_date: Date.today + 1.year, title: "foo", description: "bar"},
		{due_date: Date.today + 1.year, title: "foo", description: "bar"},
		{due_date: Date.today + 1.year, title: "foo", description: "bar"},
		{due_date: Date.today + 1.year, title: "foo", description: "bar"}
	])
end