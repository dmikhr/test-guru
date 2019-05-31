class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :trackable,
          :validatable
          :confirmable

  has_many :test_passages, dependent: :destroy
  has_many :tests, through: :test_passages
  # доступ к тестам, созданным пользователем через user.tests_created
  # тесты относятся к классу Test, связь через внешний ключ creator_id
  has_many :tests_created, class_name: 'Test', foreign_key: :creator_id

  validates :email, presence: true
  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def passed_tests_by_level(level)
    # за счет ассоциаций tests содержат только тесты данного пользователя
    # можно сократить код до
    tests.where(level: level)
  end

  def test_passage(test)
    # сортировка по убыванию - чтобы получить последний пройденный тест (если один тест проходился несколько раз)
    test_passages.order(id: :desc).find_by(test: test)
  end

end
