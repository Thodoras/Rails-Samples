class MoviesController < ApplicationController
	before_action :find_movie, only: [:show, :edit, :update, :destroy, :upvote, :downvote, :unvote]

	def submits
		# custom action for displaying the movies submited by a specific user.

		@user = User.find(params[:user])
	end

	def upvote
		#like

		@movie.upvote_by(current_user)
		redirect_to(:back)
	end

	def downvote
  		#dislike

  		@movie.downvote_by(current_user)
  		redirect_to(:back)
	end

	def unvote
		#unvote
		
		@movie.unvote_by(current_user)
  		redirect_to(:back)
  	end

	def index
		if params[:sort].blank?
			@movies = Movie.all()
		elsif params[:sort] == "likes"
			@movies = Movie.all().order(:cached_votes_up => :desc)
		elsif params[:sort] == "hates"
			@movies = Movie.all().order(:cached_votes_down => :desc)
		elsif params[:sort] == 'created_at'
			@movies = Movie.all().order('created_at DESC')
		end
	end

	def new
		@movie = current_user.movies.build
	end

	def create
		@movie = current_user.movies.build(movie_params)
		if @movie.save
			redirect_to(root_path)
		else
			render('new')
		end
	end

	def edit
		if current_user != @movie.user
			redirect_to(root_path)
		end
	end

	def update
		if @movie.update(movie_params)
			redirect_to(movie_path(@movie))
		else
			render('edit')
		end
	end

	def destroy
		@movie.destroy()
		redirect_to(root_path)
	end

	private
	def movie_params
		params.require(:movie).permit(:title, :description)
	end

	def find_movie
		@movie = Movie.find(params[:id])
	end
end
