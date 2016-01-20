class Event < ActiveRecord::Base
  belongs_to :user

  def created_by?(user)
    user_id == user.id
  end
end
