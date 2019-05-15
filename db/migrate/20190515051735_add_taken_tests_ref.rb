class AddTakenTestsRef < ActiveRecord::Migration[5.2]
  def change
    add_reference(:takentests, :user)
    add_reference(:takentests, :test)
  end
end
