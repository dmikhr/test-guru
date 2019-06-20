class UserBadge < ApplicationRecord
  belongs_to :user
  belongs_to :badge

  scope :badges_assigned_to_user, ->(user, badge) { where(user: user, badge: badge) }
end
