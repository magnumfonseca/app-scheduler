require 'rails_helper'

feature 'Event destroy' do
  scenario 'users event', :js => true do
    user = create(:user)
    user.save
    sign_in(user)

    first('.available').click
    wait_for_ajax
    expect(page).to have_css('.info.unavailable')
    expect(page).to have_css('.text-red')

    find('.text-red').click
    wait_for_ajax
    expect(page).to_not have_css('.text-red')
  end
  scenario 'users not event owner', :js => true do
    event = create(:event)
    other_user = create(:user, events: [ event ])
    other_user.save
    user = create(:user)

    sign_in(user)

    expect(page).to have_css('b', text: other_user.name)
    expect(page).to_not have_css('.glyphicon-remove');
  end
end
