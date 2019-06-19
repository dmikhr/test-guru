module BadgesHelper
  def available_rules
    BadgeManagementService::RULES
  end
end
