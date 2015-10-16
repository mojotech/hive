class Lane < ActiveRecord::Base
  belongs_to :app
  validates :app, presence: true
  validates :title, presence: true
end
