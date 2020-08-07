class LoginsController < ApplicationController

  # Исключаем проверку аут-ии для данных экшенов
  skip_before_action :require_user, only: [:new, :create]


  def new
  end

  def create
    # В params есть еще один массив logins ( указан в form_for)/ который несет значение поля email
    # используя это значение мы находим нужную строчку в БД
    student = Student.find_by(email: params[:logins][:email].downcase )

    # Если в БД нашлась запись по email? то students будет true
    # но надо проверить и введеный пароль, это делает метод authe...te
    # Если строка есть и пароли совпали, то:
    if student && student.authenticate(params[:logins][:password])
      # если успешно вошли, то в sesseion записываем значение текущего ID, чтобы хранить в куки
      session[:student_id] = student.id

      flash[:notice] = "Вы успешно вошли"
      redirect_to  student

    else
      # т.к. flash показывается до первого redirect, то дописываем к нему метод .now , который показывает моментальное сообщение
      flash.now[:notice] = "Вы ввели что-то неправильно"
      render :new
    end
  end

  def destroy
    # В данном случае мы убираем значение из куки и тогда сессия теряет текущего пользователя
    session[:student_id] =  nil
    flash[:notice] = "Вы успешно вышли из системы"
    redirect_to root_path
  end
end