class UserBadge < ApplicationRecord
  belongs_to :user
  belongs_to :badge

  scope :badges_for_user, -> (user, badge) { where(user: user).where(badge: badge) }
end
