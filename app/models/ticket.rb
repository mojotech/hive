class Ticket < ActiveRecord::Base
  belongs_to :app
  has_many :acceptance_criteria
  validates :app, presence: true
end
