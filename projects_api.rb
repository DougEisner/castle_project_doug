require 'sinatra'
require_relative 'models/project'

get '/api/projects' do
  Project.all.to_json
end

get '/api/projects/:id' do |id|
  project = Project.find_by_id(id)
  if project.nil?
    status 404
  else
    status 200
    project.to_json
  end
end

post '/api/projects' do
  project = Project.create(name: params[:name], status: params[:status])
  status 201
  project.to_json
end

put '/api/projects/:id' do |id|
  project = Project.find_by_id(id)
  if project.nil?
    status 404
  else
    project.update(status: params[:status])
    # task.update(params) # TODO: does this work? what about nils?
    status 200
    project.to_json
  end
end

delete '/api/projects/:id' do |id|
  project = Project.find_by_id(id)
  if project.nil?
    status 404
  else
    Project.destroy(id)
    status 200
  end
end
