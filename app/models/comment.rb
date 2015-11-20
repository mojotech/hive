class Comment < ActiveRecord::Base
  belongs_to :ticket

  validates :ticket, presence: true
end
