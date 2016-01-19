require 'rails_helper'

feature 'User session' do
  scenario 'unsigned user' do
    visit root_path

    expect(page).not_to have_link('Sign out')
  end

  scenario 'signed in user wants to sign out' do
    user = create(:user)
    sign_in user
    
    expect(page).to have_link('Sign out')
    click_link 'Sign out'
    expect(page).to have_link('Sign up')
  end

end
