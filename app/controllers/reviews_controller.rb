class ReviewsController < ApplicationController

	before_action :set_movie
	def index
		@reviews = @movie.reviews
	end

	def new
		@reviews = @movie.reviews.new
	end

	def create
		@reviews = @movie.reviews.new(reviews_params)
		if @reviews.save
			redirect_to movie_reviews_path, notice: "Thank for review #{@movie.title}!"
		else
			render :new
		end
	end

	private

	def reviews_params
		params.require(:review).permit(:name, :stars, :comment)
	end

	def set_movie
		@movie = Movie.find(params[:movie_id])
	end
end
