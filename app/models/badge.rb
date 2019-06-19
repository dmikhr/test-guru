# Правила выдачи бейджей реализованы слеующим образом: Есть модель Badge - в ней хранятся основные атрибуты - название и ссылка на изображение (опционально можно добавить еще описание) Правила присвоения бейджей хранятся в отдельной модели BadgeRule, которая имеет связь belongs_to с моделью Badge.
class Badge < ApplicationRecord
  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges

  validates :name, :image_path, presence: true
  validates :value, numericality: { only_integer: true, greater_than_or_equal_to: 0, message: "must be integer and greater or equal to 0" }, allow_blank: true
  # https://guides.rubyonrails.org/active_record_validations.html#inclusion
  validates :rule, inclusion: { in: BadgeManagementService::RULES, message: "%{value} is not allowed" }

end
