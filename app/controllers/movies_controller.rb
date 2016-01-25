class MoviesController < ApplicationController
  def index
  	@movie = Movie.recently
  end

  def show
  	@movie = Movie.find(params[:id])
  end

  def edit
  	@movie = Movie.find(params[:id])
  end

  def update
  	# The fail method in Ruby intentionally raises an exception.
  	# fail
  	@movie = Movie.find(params[:id])
  	# movie_params = params.require(:movie).permit(:title, :description, :rating, :released_on, :total_gross)
  	if @movie.update(movie_params)
  	# render "show" 
  	  redirect_to movie_path, notice: "Movie was updated successfully"
    else
      render :edit
    end
  	# we can use the "redirect_to @movie" it mean that you go to show method in MoviesController
  end

  def new
  	@movie = Movie.new
  end

  def create
    # movie_params = params.require(:movie).permit(:title, :description, :rating, :released_on, :total_gross)
	  @movie = Movie.new(movie_params)
	  if @movie.save
	    redirect_to @movie, notice: "Movie was created successfully"
    else
      render :new
    end
	end

	def destroy
		@movie = Movie.find(params[:id])
		@movie.destroy
		redirect_to root_path, alert: "Movie successfully deleted!"
	end

	private

  def movie_params
    params.require(:movie).permit(:title, :description, :rating, :released_on, :total_gross, :cast, :director, :duration, :image)
  end


end
