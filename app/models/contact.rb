# https://stackoverflow.com/questions/25460319/rails-validate-input-without-need-of-models
# https://stackoverflow.com/questions/38611405/how-to-do-email-validation-in-ruby-on-rails
# модель без сохранения данных в БД, только для валидации данных в форме
class Contact
  include ActiveModel::Model
  attr_accessor :id, :name, :email, :message
  validates :name, :email, :message, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  # https://api.rubyonrails.org/classes/ActiveModel/Model.html
  # для корректной работы display_errors с resource_id: resource.id
  def initialize(attributes={})
    super
    @id = 1
  end
end
