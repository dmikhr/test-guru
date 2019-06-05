module ApplicationHelper

  def current_year
    Date.today.year
  end

  def github_url(caption, path)
    link_to caption, "https://github.com/#{path}", target: "_blank"
  end

  # хэлпер для flash сообщений с bootstrap
  def show_flash_message(type)
    content_tag :div, flash[type], class: "#{type.to_s} alert-primary"
  end

  def show_user_name
    "#{current_user.first_name} #{current_user.last_name}"
  end

  # решил добавить в приложении функцию переключения языка через интерфейс
  def switch_language
    en_signature = "?lang=en"
    if request.original_url.include?(en_signature)
      link_to 'RU', request.original_url.gsub(en_signature, '')
    else
      link_to 'EN', "#{request.original_url}#{en_signature}"
    end
  end

end
