class Ticket < ActiveRecord::Base
  belongs_to :app
  has_many :acceptance_criteria
end
