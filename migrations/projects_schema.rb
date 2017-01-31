require 'active_record'
require_relative '../environment'

class CreateProjectsTable < ActiveRecord::Migration[5.0]

  def up
    puts 'creating projects table'

    create_table :projects do |t|
      t.string :name
      t.string :status
      t.timestamps
    end

    puts 'created projects table'
  end

  def down
    puts 'dropping projects table'

    drop_table :projects

    puts 'dropped projects table'
  end
end

def main
  action = (ARGV[0] || :up).to_sym

  CreateProjectsTable.migrate(action)
end

main if __FILE__ == $PROGRAM_NAME
