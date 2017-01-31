require_relative '../environment'

class Project < ActiveRecord::Base
  validates :name, :status, presence: true
  has_many :tasks
end

class Task < ActiveRecord::Base
  validates :name, :priority, :status, presence: true
  belongs_to :project
end
