module ApplicationHelper

  def current_year
    Date.today.year
  end

  def github_url(caption, path)
    link_to caption, "https://github.com/#{path}", target: "_blank"
  end

  # хэлпер для flash сообщений
  def show_flash_message(type)
    css_style = { alert: 'flash alert', notice: 'flash notice'}
    content_tag :p, flash[type], class: css_style[type]
  end

  def show_user_name
    "#{current_user.first_name} #{current_user.last_name}"
  end

end
