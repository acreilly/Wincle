class PostsController < ApplicationController
include SessionsHelper


# wont need index soon
  def index
    employee = current_user.employee
    algorithm = SearchAlgorithm.new(employee, Post.all)
    ordered_posts = algorithm.search
    top_results = ordered_posts[0..19]
    render json: top_results.to_json
  end

  def employees_post
    employer = current_user.employer
    algorithm = SearchAlgorithm.new(employer, Employee.all)
    ordered_posts = algorithm.search
    top_results = ordered_posts[0..19]
    render json: top_results.to_json
  end

  def employers_post
    employee = current_user.employee
    algorithm = SearchAlgorithm.new(employee, Post.all)
    ordered_posts = algorithm.search
    top_results = ordered_posts[0..19]
    render json: top_results.to_json
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