require 'rails_helper'

feature 'User edit profile' do
  scenario 'with success' do
    user = create(:user)
    sign_in(user)

    click_link 'Edit Profile'

    fill_in 'user_name', with: 'New name'
    fill_in 'user_current_password', with: user.password

    click_button 'Update'
    expect(page).to have_css('a', text: 'User: New name')
  end
end
