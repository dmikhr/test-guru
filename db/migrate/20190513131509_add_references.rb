class AddReferences < ActiveRecord::Migration[5.2]
  def change
    add_reference(:tests, :categories)
    add_reference(:questions, :tests)
    add_reference(:answers, :questions)
  end
end
