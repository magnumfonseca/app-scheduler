require 'rails_helper'

feature 'User signup' do
  scenario 'with success' do
    name = 'Teste'
    email = 'octocat@github.com'
    password = '1superpassword1'

    visit root_path
    click_link 'Sign up'
    fill_in_sign_up_form_with(name, email, password)

    expect(page).to have_css('a', text: 'Sign out')
  end

  def fill_in_sign_up_form_with(name, email, password)
    puts name
    fill_in 'user_name', with: name
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    fill_in 'user_password_confirmation', with: password
    click_button 'Sign up'
  end
end
