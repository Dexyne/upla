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
    upload_folder_path = './public/uploads/'
    year  = Time.now.year.to_s
    month = Time.now.strftime "%m"

    FileUtils.mkdir_p "#{upload_folder_path}#{year}/#{month}" unless File.directory?("#{upload_folder_path}#{year}/#{month}")

    if File.directory?("#{upload_folder_path}#{year}/#{month}")
      # TODO: add a try/catch
      File.open("#{upload_folder_path}#{year}/#{month}/" + params[:file_to_upload][:filename], "w") do |f|
        if f.write(params[:file_to_upload][:tempfile].read)
          flash_message(:info, "File uploaded.")
        else
          flash_message(:warning, "Error.")
        end
      end
    end
  else
    flash_message(:warning, "Do you want to upload nothing?!")
  end

  redirect '/'
end

private
  # TODO: refactor
  def flash_message(type = :info, message)
    if type == :info
      flash[type] = "<div class=\"alert alert-success alert-dismissable\">#{message}</div>"
    else
      flash[type] = "<div class=\"alert alert-error alert-dismissable\">#{message}</div>"
    end
  end
