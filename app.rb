require 'rubygems'
require "sinatra/base"

class App < Sinatra::Base

  set :title, 'Rui Space!'

  get '/' do
    settings.title
  end
  # $0 is the executed file
  # __FILE__ is the current file
  #run! if __FILE__ == $0
end