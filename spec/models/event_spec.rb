require 'rails_helper'

RSpec.describe Event, type: :model do
  describe "created_by?" do
    it "returns true when user is event owner" do
      event = create(:event)
      user = create(:user, events: [event])
      expect(event.created_by?(user)).to be_truthy
    end
    it "returns false whe user is'nt event ouner" do
      event = create(:event)
      user = create(:user, events: [event])
      other_user = create(:user)
      expect(event.created_by?(other_user)).to be_falsy
    end
  end

  describe "event uniqueness" do
    it "can not allow two events at same time" do
      user = create(:user)
      user.events.build(week: 1, day: "ter", hour:11)
      user.save
      event2 = Event.new(week: 1, day: "ter", hour:11)
      expect(event2.valid?).to be_falsy
    end
  end
end
