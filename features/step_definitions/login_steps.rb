When(/^a hive user logs in$/) do
  roles.hive_user.login
end

When(/^a hive user logs out$/) do
  roles.hive_user.login
  roles.hive_user.logout
end

Then(/^the user should be logged in$/) do
  expect(roles.hive_user).to see :signout_link
end

Then(/^the user should be logged out$/) do
  expect(roles.hive_user).to see :github_signin_link
end
