module GistsHelper
  def truncate_question(body)
    if body.size <= 25
      body
    else
      "#{body[0..25]}..."
    end
  end

  def gist_hash(url)
    url.split('/').last
  end
end
