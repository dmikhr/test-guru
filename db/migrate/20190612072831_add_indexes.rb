class AddIndexes < ActiveRecord::Migration[5.2]
  def change
    # название таблицы и атрибута, по которому строится индекс
    # add_index :tests, :creator_id
    # композитный индекс, условие уникальности - не может существовать 2 строки с одинаковыми title и level
    add_index :tests, %i[title level], unique: true
  end
end
