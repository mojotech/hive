module Roles
  class HiveUser < Dill::Role
    # Login
    widget :github_signin_link, '.sign_in_link'
    widget :signout_link, '.sign_out_link'

    def login
      visit '/'
      click :github_signin_link
    end

    def logout
      click :signout_link
    end

    # App
    form :new_project_form, '#new_app' do
      text_field :name, 'app[name]'
      select :repository_full_name, 'app[repository_full_name]'
    end

    widget :app, -> (name = nil) { name.present? ? ['li', text: name] : ['li'] }

    def create_new_app(name)
      submit :new_project_form, name: name
    end

    # Ticket
    form :edit_ticket_form, '.edit_ticket' do
      text_field :description, 'ticket[description]'
    end

    def update_ticket(description)
      submit :edit_ticket_form, description: description
    end

    def see_ticket_description?(description)
      widget(:edit_ticket_form).widget(:description).text == description
    end

    # Lane Tickets
    form :edit_ticket_points_form, -> (ticket_id) { [".ticket-#{ticket_id} .points-form"] } do
      select :points, 'ticket[points]'
    end

    def set_point_value(id, points)
      widget(:edit_ticket_points_form, id).submit_with(points: points)
    end

    def see_ticket_point_value?(id, points)
      widget(:edit_ticket_points_form, id).widget(:points).value == points.to_s
    end
  end
end
