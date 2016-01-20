class Event < ActiveRecord::Base
  belongs_to :user
  validates :hour, :day, :week, presence: true
  validates :hour, uniqueness: {scope: [:day, :week]}

  def created_by?(user)
    user_id == user.id
  end
end
