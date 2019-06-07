class Gist < ApplicationRecord
  belongs_to :question
  belongs_to :user

  # URL должен существовать
  validates :url, presence: true
  # и ссылаться на gist на gist.github.com
  validate :validate_gist_url

  private

  def validate_gist_url
    gist_url = URI.parse(url)
    if !gist_url.host.eql?("gist.github.com") || gist_url.path.blank?
      errors.add(:url, message: "URL must lead to gist on gist.github.com")
    end
  end
end
