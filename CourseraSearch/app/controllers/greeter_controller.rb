class GreeterController < ApplicationController
  def hello
  	random_names = ['Alex', 'Joe', 'Michael']
  	@name = random_names.sample
  	@time = Time.now
  	@displayed ||= 0
  	@displayed += 1
  end
  def goodbye
  end
end
