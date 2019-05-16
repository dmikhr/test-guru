class CreatePassedTests < ActiveRecord::Migration[5.2]
  def change
    create_table :passed_tests do |t|

      t.timestamps
    end
  end
end
