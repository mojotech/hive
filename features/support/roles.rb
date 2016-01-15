module Roles
  class << self
    Dir[Rails.root + 'features/support/roles/*.rb'].each do |e|
      role = File.basename(e, '.rb')

      define_method role do
        "Roles::#{role.camelize}".constantize.new
      end
    end
  end

  def roles
    Roles
  end
end

World Roles
