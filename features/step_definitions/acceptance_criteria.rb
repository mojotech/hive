When(/^a user adds an acceptance criterion to a ticket$/) do
  allow_any_instance_of(Repository).to receive(:branches).and_return []

  user = FactoryGirl.create(:user, github_user_id: '1')
  ticket = FactoryGirl.create(:ticket)
  app = ticket.lane.app
  user.apps << app

  @criterion_description = 'New criterion description'

  step 'a hive user logs in'

  visit app_ticket_path(app, ticket)

  roles.hive_user.create_acceptance_criterion(@criterion_description)
end

Then(/^the user should see the ticket has a new acceptance criterion$/) do
  expect(roles.hive_user).to see :acceptance_criterion_description,
                                 @criterion_description
end
