require_relative '../models/robot.rb'

class RobotWorldApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)

  get '/' do
    redirect '/robots'
  end

  get '/robots' do
    @robots = Robot.all
    erb :index
  end
  
  get '/robots/new' do
    erb :new
  end

  get '/robots/:id' do
    @robot = Robot.find(params[:id])
    erb :show
  end


  post '/robots' do 
    robot = Robot.create(params[:robot])
    robot.save
    redirect '/robots'
  end

end
