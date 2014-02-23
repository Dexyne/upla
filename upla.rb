# upla.rb
require 'sinatra'
require 'slim'
require 'sinatra/flash'

enable :sessions

get '/' do
	slim :home
end

# Handle POST-request (Receive and save the uploaded file)
post '/upload' do
	File.open('public/uploads/' + params['file_to_upload'][:filename], "w") do |f|
		if f.write(params['file_to_upload'][:tempfile].read)
			flash[:info] = "Fichier envoy&eacute; avec succ&egrave;s."
		else
			flash[:warning] = "Une erreur est survenue."
		end
	end

	redirect '/'
end
