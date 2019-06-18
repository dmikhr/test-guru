# Правила выдачи бейджей реализованы слеующим образом: Есть модель Badge - в ней хранятся основные атрибуты - название и ссылка на изображение (опционально можно добавить еще описание) Правила присвоения бейджей хранятся в отдельной модели BadgeRule, которая имеет связь belongs_to с моделью Badge.
class Badge < ApplicationRecord
  has_many :user_badges, dependent: :destroy
  has_many :users, through: :user_badges
  has_many :badge_rules, dependent: :destroy

  validates :name, :image_path, presence: true

end
