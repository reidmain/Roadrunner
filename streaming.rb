require 'sinatra'

set :server, :thin

get '/' do
	stream do |out|
		out << "It's gonna be legen -\n"
		sleep 0.5
		out << " (wait for it) \n"
		sleep 5
		out << "- dary!\n"
  end
end
