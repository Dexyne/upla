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
  unless params['file_to_upload'].nil?
    File.open('public/uploads/' + params['file_to_upload'][:filename], "w") do |f|
      if f.write(params['file_to_upload'][:tempfile].read)
        flash[:info] = "<div class=\"alert alert-success alert-dismissable\">Fichier envoy&eacute; avec succ&egrave;s.</div>"
      else
        flash[:warning] = "<div class=\"alert alert-error alert-dismissable\">Une erreur est survenue.</div>"
      end
    end
  else
    flash[:warning] = "<div class=\"alert alert-warning alert-dismissable\">Vous voulez uploader quelque chose d'inexistant ?!</div>"
  end

  redirect '/'
end
