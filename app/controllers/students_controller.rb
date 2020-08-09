class StudentsController < ApplicationController
  # перед каждым из перечисленных методов запустить метод set_student
  before_action :set_student, only: [:show, :edit, :update]

  # crbgyenm проверку входа для данных экшенов
  skip_before_action :require_user, only: [:new, :create]

  # Проверить текущий пользователь - это хозяин карточки?
  before_action :require_same_student, only: [:edit, :update]



  def index
    @students = Student.all
  end

  def show
    # @student = Student.find(params[:id])
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params )
    if @student.save
      flash[:notice] = "Вы успешно зарегистрировлись"
      redirect_to @student
    else
      flash[:error] =  "У вас есть ошибки"
      render :new
    end
  end

  # Экшен  отрисовыает шаблон для редактированияБ поэтому ему нужны параметры для отрисовки
  def edit
    # @student = Student.find(params[:id])
  end

  # Экшн изменяет параметры, поэтому использует POST и params
  def update
    # идентичен Create, но сначала ищет в БД по ID и только потом пытается update строку
    # @student = Student.find(params[:id])
    if @student.update(student_params)
      flash[:notice] = "Изменения сохранены"
      # После отправляем на собственную страницу
      # согласно роутингу это будет students/id ,
      # но в сокращенке можно просто писать id
      #  вместо redirect_to student_path(@student)
       redirect_to @student
    else
      flash[:error] =  "У вас есть ошибки"
      render :new
    end
  end

  private

  def student_params
    params.require(:student).permit(:name, :email, :password)
  end

  def set_student
    @student = Student.find(params[:id])
  end

  def require_same_student
    # если текущий пользователь != данному студенту
    if current_user != @student
      # то уведомляем и пересылаем на собственную карточку
      flash[:notice] = " Вы можете редактировать только свой профиль"
      redirect_to student_path(current_user)
    end
  end


end