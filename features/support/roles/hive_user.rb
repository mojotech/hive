module Roles
  class HiveUser < Dill::Role
    widget :github_signin_link, ['a', text: 'Sign in with Github']
    widget :signout_link, ['a', text: 'Sign out']

    def login
      visit '/'
      click :github_signin_link
    end

    def logout
      click :signout_link
    end
  end
end
