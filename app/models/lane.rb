class Lane < ActiveRecord::Base
  belongs_to :app
  has_many :tickets
  validates :app, presence: true
  validates :title, presence: true
end
