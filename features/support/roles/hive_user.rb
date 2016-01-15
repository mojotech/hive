module Roles
  class HiveUser < Dill::Role
    widget :github_signin_link, '.sign_in_link'
    widget :signout_link, '.sign_out_link'

    def login
      visit '/'
      click :github_signin_link
    end

    def logout
      click :signout_link
    end
  end
end
