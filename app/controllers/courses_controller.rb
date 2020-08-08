class CoursesController < ApplicationController
  skip_before_action :require_user


  def index
    @courses = Course.all
  end


  def new
    @course = Course.new
  end

  def show
        @course = Course.find(params[:id])
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
