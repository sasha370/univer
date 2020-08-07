module ApplicationHelper


  # Метод, который аутентифицирует пользователя и показывает разные действия
  # используется в меню
  def session_link
    if logged_in?
      link_to("Выйти", logout_path, method: :delete)
    else
      link_to("Войти", login_path)
    end

  end
end
