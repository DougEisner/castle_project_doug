require_relative '../environment'

class Project < ActiveRecord::Base
  validates :name, :status, presence: true
  has_many :tasks
end
