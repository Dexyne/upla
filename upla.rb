require 'rubygems'
require 'sinatra'
#require 'rack-flash'

#use Rack::Flash
enable :sessions

get "/" do
  haml :home
end

# Handle POST-request (Receive and save the uploaded file)
post "/upload" do
  File.open('public/uploads/' + params['file_uploaded'][:filename], "w") do |f|
    f.write(params['file_uploaded'][:tempfile].read)
  end
  # flash[:notice] = "Fichier uploader avec succès."
  redirect "/"
end
