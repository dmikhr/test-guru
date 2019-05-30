module ApplicationHelper

  def current_year
    Date.today.year
  end

  def github_url(caption, path)
    link_to caption, "https://github.com/#{path}", target: "_blank"
  end

  # хэлпер для flash сообщений
  def show_flash_message
    content_tag :p, flash[:alert], class: 'flash alert'
  end

end
