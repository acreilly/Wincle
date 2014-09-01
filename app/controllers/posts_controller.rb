class PostsController < ApplicationController
include SessionsHelper

  def index
    employee = current_user.employee
    algorithm = SearchAlgorithm.new(employee, Post.all)
    ordered_posts = algorithm.search
    top_results = ordered_posts[0..19]
    render json: top_results.to_json
    # @posts = Post.all
  end

  def new
    @post = Post.new
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