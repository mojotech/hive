Given(/^a ticket exists for a project$/) do
  allow_any_instance_of(Repository).to receive(:branches).and_return []

  user = create(:user, github_user_id: 1)
  @application = create(:app, users: [user])
  @ticket = create(:ticket, lane: create(:lane, app: @application))
end

When(/^an authorized user edits the ticket description$/) do
  roles.hive_user.login
  allow_any_instance_of(Repository).to receive(:branches).and_return []

  @new_description = 'Lorem ipsum'

  visit app_ticket_path(@application, @ticket)
  roles.hive_user.update_ticket @new_description
end

Then(/^the user should see the ticket description has changed$/) do
  expect(roles.hive_user).to see :ticket_description, @new_description
end
