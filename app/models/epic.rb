class Epic < ActiveRecord::Base
  belongs_to :app
  has_and_belongs_to_many :tickets
  validates :app, presence: true
end
