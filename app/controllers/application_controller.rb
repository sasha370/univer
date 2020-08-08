class ApplicationController < ActionController::Base

  # чтобы эти методы были видны другим контроллерам
  helper_method :current_user, :logged_in?, :is_admin?

  # Задаем для всех контроллеров ограничение: перед загрузкой проверить зарегистрирован ли пользователь
  before_action :require_user

  def current_user
  # если в куки есть пользователь, то мы находим его в базе и присваиваем переменной, чтобы в дальнейшем ее использовать
  # чтобы постоянно не обращаться к БД , мы  ставим ||
  #  и только если curren_user не существует, идет обращение к БД
  @current_user ||= Student.find(session[:student_id]) if session[:student_id]
  end

  def logged_in?
    # !! возвращает true/false если переменная существует
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:notice] = " Вы должны быть зарегистрированны, чтобы просматривать это"
      redirect_to root_path
    end
  end



end
