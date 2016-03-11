When(/^a hive user sets the point value of a ticket$/) do
  # The fake github response uses "1" as the id.
  user = FactoryGirl.create(:user, github_user_id: '1')
  @ticket = FactoryGirl.create(:ticket)
  app = @ticket.lane.app
  user.apps << app

  @new_point_value = 7

  step 'a hive user logs in'

  visit app_path(app)
  roles.hive_user.set_point_value(@ticket.id, @new_point_value)
end

Then(/^the user should see the ticket has the new point value$/) do
  expect(roles.hive_user).to see :ticket_point_value,
                                 @ticket.id,
                                 @new_point_value
end
