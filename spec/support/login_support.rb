module LoginSupport
  def log_in_as(user)
    visit root_path
    click_on "Log in"
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on "LOGIN"
  end

  RSpec.configure do |config|
    config.include LoginSupport
  end
end
