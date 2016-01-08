

When(/^a hive user sets the point value of a ticket$/) do
  # The fake github response uses "1" as the id.
  user = FactoryGirl.create(:user, github_user_id: "1")
  app = user.apps.create!

  step 'a hive user logs in'

  visit app_path(app)
  pending # express the regexp above with the code you wish you had
end

Then(/^the user should see the ticket has the new point value$/) do
  pending # express the regexp above with the code you wish you had
end
