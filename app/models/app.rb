class App < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :lanes
  has_many :tickets, through: :lanes
end
