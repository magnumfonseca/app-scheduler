module SignInHelper
  def sign_in(user)
    visit root_path
    click_link 'Sign in'

    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password

    click_button 'Sign in'
  end
end

RSpec.configure do |config|
  config.include SignInHelper, type: :feature
end
