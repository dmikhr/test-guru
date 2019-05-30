class RemoveNullConstraintsUser < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:users, :login, true)
    change_column_null(:users, :name, true)
    change_column_null(:users, :role, true)
    change_column_null(:users, :password, true)
  end
end
