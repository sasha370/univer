class StudentsController < ApplicationController
  # перед каждым из перечисленных методов запустить метод set_student
  before_action :set_student, only: [:show, :edit, :update]


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
    params.require(:student).permit(:name, :email)
  end

  def set_student
    @student = Student.find(params[:id])
  end


end