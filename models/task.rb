require_relative '../environment'

class Task < ActiveRecord::Base
  validates :name, presence: true
  validates :priority, numericality: { only_integer: true, greater_than: 0 }
  validates :status, inclusion: { in: [true, false] }
  belongs_to :project
end
