require 'sinatra'
require_relative 'models/task'

get '/api/tasks' do
  Task.all.to_json
end

get '/api/tasks/:id' do |id|
  task = Task.find_by_id(id)
  if task.nil?
    status 404
  else
    status 200
    task.to_json
  end
end

post '/api/tasks' do
  task = Task.create(name: params[:name], priority: params[:priority], status: params[:status], project_id: params[:project_id])
  status 201 # Check if valid?
  task.to_json
end

put '/api/tasks/:id' do |id|
  task = Task.find_by_id(id)
  if task.nil?
    status 404
  else
    task.update(status: params[:status])
    # task.update(params) # TODO: does this work? what about nils?
    status 200
    task.to_json
  end
end

delete '/api/tasks/:id' do |id|
  task = Task.find_by_id(id)
  if task.nil?
    status 404
  else
    Task.destroy(id)
    status 200
  end
end
