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
  end
end
