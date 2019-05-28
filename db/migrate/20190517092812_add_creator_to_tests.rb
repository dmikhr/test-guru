class AddCreatorToTests < ActiveRecord::Migration[5.2]
  def change
    # создаем поле для хранения id пользователя - автора теста
    # указываем, что foreign_key указывает на таблицу users
    add_reference :tests, :creator, foreign_key: { to_table: :users }
  end
end
