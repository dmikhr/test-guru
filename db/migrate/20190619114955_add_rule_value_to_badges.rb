class AddRuleValueToBadges < ActiveRecord::Migration[5.2]
  def change
    add_column :badges, :rule, :string
    # для хранения id или level
    add_column :badges, :value, :integer
  end
end
