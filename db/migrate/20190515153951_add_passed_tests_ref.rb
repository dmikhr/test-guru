class AddPassedTestsRef < ActiveRecord::Migration[5.2]
  def change
    add_reference(:passed_tests, :user)
    add_reference(:passed_tests, :test)
  end
end
