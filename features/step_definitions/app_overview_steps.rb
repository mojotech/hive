When(/^a hive user adds an overview to an app$/) do
  allow_any_instance_of(User).to receive(:repositories) do |user|
    [Repository.new(
        name: 'fake_name',
        owner_login: user.nickname,
        auth_token: user.auth_token
      )]
  end

  user = create(:user, github_user_id: 1)
  @application = create(:app, users: [user])

  @overview_text = 'new overview text'

  step 'a hive user logs in'

  visit edit_app_path(@application)
  roles.hive_user.set_app_overview(@overview_text)
end

Then(/^the user should be able to see the overview$/) do
  visit overview_app_path(@application)
  expect(roles.hive_user).to see :app_overview, @overview_text
end
