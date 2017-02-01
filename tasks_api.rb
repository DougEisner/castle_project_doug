require 'sinatra'
require_relative 'models/task'

get '/api/tasks/filter' do
  status = params[:status]
  if status == 'true'
    tasks = Task.where('status = true')
  elsif status == 'false'
    tasks = Task.where('status = false')
  else
    tasks = Task.all
  end

  priority = params[:priority]
  unless priority.nil?
    tasks = tasks.where("priority = #{priority}")
  end

  name = params[:name]
  unless name.nil?
    tasks = tasks.where("LOWER(name) LIKE ?", "%#{name}%")
  end

  tasks.order(priority: :desc).to_json
end

get '/api/tasks/:id' do |id|
  task = Task.find_by_id(id)
  if task.nil?
    status 404
  else
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
    task.to_json
  end
end

delete '/api/tasks/:id' do |id|
  task = Task.find_by_id(id)
  if task.nil?
    status 404
  else
    Task.destroy(id)
  end
end
