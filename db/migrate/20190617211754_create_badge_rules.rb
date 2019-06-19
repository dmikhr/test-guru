# решил не удалять эту миграцию, а создать новую с удалением таблицы
# как я понял, если миграции ушли в удаленный репозитарий, то старую миграцию лучше не откатывать, а создать новую миграцию
class CreateBadgeRules < ActiveRecord::Migration[5.2]
  def change
    create_table :badge_rules do |t|
      t.references :badge, foreign_key: true
      t.references :test, foreign_key: true
      t.references :category, foreign_key: true
      t.integer :level
      t.boolean :first_attempt, default: false

      t.timestamps
    end
  end
end
