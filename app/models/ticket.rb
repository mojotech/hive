class Ticket < ActiveRecord::Base
  belongs_to :lane
  has_many :acceptance_criteria
  belongs_to :requester, class_name: 'User'
  belongs_to :owner, class_name: 'User'
  has_and_belongs_to_many :epics

  validates :requester, presence: true
  validates :lane, presence: true
  validates :title, presence: true

  def branch_name
    "#{owner.try(:nickname) || 'ticket'}/#{id}/#{title.parameterize}"
  end
end
