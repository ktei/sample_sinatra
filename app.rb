require 'rubygems'
require "sinatra/base"
require "sinatra/config_file"
require 'sinatra/contrib/all'
require 'active_record'
require "sinatra/activerecord"
require "./models/foo"

class App < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  register Sinatra::ActiveRecordExtension

  configure :production do
    ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')
  end

  register Sinatra::ConfigFile
  config_file 'config/environments.yml'



  set :root, File.dirname(__FILE__)

  set :title, 'Rui Space!'

  get '/' do
    settings.title
  end

  get '/add/:name' do
    foo = Foo.new
    foo.name = params[:name]
    foo.save
    "#{params[:name]} has been successfully added!"
  end

  get '/foos/rm/:name' do
    foos = Foo.find_by name: params[:name]
    foos.destroy
    redirect '/foos'
  end

  get '/foos' do
    all = Foo.all
    result = '<ul>'
    all.each do |foo|
      result << "<li>#{foo.name}</li>"
    end
    result << '</ul>'
    result
  end
end