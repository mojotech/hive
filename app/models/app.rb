class App < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :lanes
  has_many :tickets, through: :lanes

  validates :repository_name, presence: true
  validates :repository_owner, presence: true

  def repository_full_name
    "#{repository_owner}/#{repository_name}"
  end

  def repository_full_name=(full_name)
    self.repository_owner, self.repository_name = full_name.split('/')
  end

  def documentation_directory
    'docs'
  end
end
