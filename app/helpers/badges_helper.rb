module BadgesHelper
  def select_category
    @badge.badge_rules.first.category_id
  end

  def select_test
    @badge.badge_rules.first.test_id
  end

  def select_level
    @badge.badge_rules.first.level
  end

  def level_value
    @badge.badge_rules.first.level
  end

  def select_check_box
    @badge.badge_rules.first.first_attempt
  end
end
