class RemoveBadgeRules < ActiveRecord::Migration[5.2]
  def change
    drop_table :badge_rules  
  end
end
