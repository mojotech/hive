class Ticket < ActiveRecord::Base
  belongs_to :app
  has_many :acceptance_criteria
  belongs_to :requester, class_name: "User"
  belongs_to :owner, class_name: "User"

  validates :requester, presence: true
  validates :app, presence: true
  validates :title, presence: true
end
