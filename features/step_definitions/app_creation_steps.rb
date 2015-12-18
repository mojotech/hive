When(/^a hive user creates an app with a github repository$/) do
  step 'a hive user logs in'
  allow_any_instance_of(User).to receive(:repositories) do |user|
    [Repository.new(
        name: 'fake_name',
        owner_login: user.nickname,
        auth_token: user.auth_token
      )]
  end
  @new_app_name = 'New App'
  visit new_app_path
  roles.hive_user.create_new_app @new_app_name
end

Then(/^the user should see the app they created$/) do
  expect(roles.hive_user).to see :app, @new_app_name
end
