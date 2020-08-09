class CoursesController < ApplicationController
  # Перед показом Index и show, нам надо сбросить проверкуна аутен-ю
  skip_before_action :require_user, only: [:index, :show]

  # Проверяем, есть ли у пользователя права Админа
  before_action :is_admin?, only: [:new, :create, :edit, :update, :destroy]
  # Находим необходимы для экшена курс в БД
  before_action :find_course, only: [:show, :edit, :update, :destroy]

  def index
    @courses = Course.all
  end

  def show
  end

  def edit
  end

  def update
    if @course.update(permit_params)
      flash[:notice] = "Данные успешно сохранены"
      redirect_to course_path(@course)
    else
      flash[:notice] = "Произошла ошибка во время сохранения"
      render :new
    end
  end


  def new
    @course = Course.new
  end

  def create
    @course = Course.new(permit_params)
    if @course.save
      flash[:notice] = "Курс успешно создан"
      redirect_to courses_path
    else
      flash[:notice] = "У вас есть ошибки, перепроверьте"
      render :new
    end
  end


  def destroy
    @course.delete
    flash[:notice] = "Курс был удален"
    redirect_to courses_path
  end

  private

  def permit_params
    params.require(:course).permit(:short_name, :name, :description)
  end

  def find_course
    @course = Course.find(params[:id])
  end

  def is_admin?
    if current_user.admin == false
      redirect_to courses_path
      flash[:notice] = " Только администратор сожет создавать новые курсы"
    end
  end

end
