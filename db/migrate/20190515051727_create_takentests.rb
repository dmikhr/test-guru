class CreateTakentests < ActiveRecord::Migration[5.2]
  def change
    create_table :takentests do |t|

      t.timestamps
    end
  end
end
