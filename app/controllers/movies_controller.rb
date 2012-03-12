class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.rates
    @highlight = "hilite"
    if params[:ratings].nil?
      @checked = @all_ratings
      params[:sort].nil? ? @movies = Movie.all : @movies = Movie.order(params[:sort])
    else
      @checked = params[:ratings]
      @movies = Movie.filter_by_rating(params[:ratings]).order(params[:sort])
    end
    session[:sort] = params[:sort] unless params[:sort].nil?
    session[:ratings] = params[:ratings] unless params[:ratings].nil?
    if !session[:ratings].nil? && ( params[:ratings].nil? || params[:sort].nil? )
      redirect_to :action => :index, :sort => session[:sort] || "", :ratings => session[:ratings] || ""
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
