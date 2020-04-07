module LoginSupport
  def log_in_as(user)
    visit root_path
    click_on "Log in"
    fill_in 'Email', with: 'hoge@example.com'
    fill_in 'Password', with: 'hogehoge'
    click_on "LOGIN"
  end

  RSpec.configure do |config|
    config.include LoginSupport
  end
end
