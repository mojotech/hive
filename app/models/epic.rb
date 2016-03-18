class Epic < ActiveRecord::Base
  belongs_to :app
  validates :app, presence: true
end
