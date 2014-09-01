class PostsController < ApplicationController

  def index
    # employer = current_user.employer
    # algorithm = Algorithm.new(employer, Post.all)
    # ordered_posts = algorithm.search
    # top_results = ordered_sightings[0..19]
    # binding.pry
    # render json: top_results.to_json(methods: [:long_date])
    @posts = Post.all
  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end


  def destroy
  end

end