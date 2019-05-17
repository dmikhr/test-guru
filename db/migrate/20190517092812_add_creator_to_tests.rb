class AddCreatorToTests < ActiveRecord::Migration[5.2]
  def change
    # создаем поле для хранения id пользователя - автора теста 
    add_reference :tests, :creator, foreign_key: true
  end
end
