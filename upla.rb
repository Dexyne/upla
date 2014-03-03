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
  unless params[:file_to_upload].nil?
    upload_folder_path = 'public/uploads/'
    year  = Time.now.year.to_s
    month = Time.now.strftime "%m"

    Dir.mkdir("#{upload_folder_path}#{year}") unless File.exists?("#{upload_folder_path}#{year}")
    Dir.mkdir("#{upload_folder_path}#{year}/#{month}") unless File.exists?("#{upload_folder_path}#{year}/#{month}")

    if File.directory?("#{upload_folder_path}#{year}/#{month}")
      File.open("#{upload_folder_path}#{year}/#{month}/" + params[:file_to_upload][:filename], "w") do |f|
        if f.write(params[:file_to_upload][:tempfile].read)
          flash[:info] = "<div class=\"alert alert-success alert-dismissable\">Fichier envoy&eacute; avec succ&egrave;s.</div>"
        else
          flash[:warning] = "<div class=\"alert alert-error alert-dismissable\">Une erreur est survenue.</div>"
        end
      end
    end
  else
    flash[:warning] = "<div class=\"alert alert-warning alert-dismissable\">Vous voulez uploader quelque chose d'inexistant ?!</div>"
  end

  redirect '/'
end
