require 'sinatra'
require 'json'

configure do
  file = File.read('bathroom-config.json')
  bathrooms = JSON.parse(file)
  bathrooms.map{|k,v|  v["status"]= "open"} # default status to open
  set :bathrooms, bathrooms

  default_bathroom = bathrooms.map{|key, value| key if value["default"]}.compact[0]
  set :default, default_bathroom

  set :open, %w{ simple_smile +1 toilet poop }
  set :closed, %w{ thumbsdown heavy_exclamation_mark warning non-potable_water no_entry }
end

get '/' do
  if settings.default && !params.has_key?("text") || params["text"].empty?
    availability(settings.default)
  elsif bathrooms[short_name]
    availability(short_name)
  else
    "I don't know that bathroom. Try #{bathrooms.keys.join(' or ')}."
  end
end

post '/update' do
  # hard code default for right now
  short_name = params[:name]

  settings.bathrooms[settings.default]["status"] = params[:status]
end

def availability(short_name)
  if settings.bathrooms[short_name]["status"] == 'open'
    "#{open_icon} #{settings.bathrooms[short_name]["name"]} is open for business."
  else
    "#{closed_icon} #{settings.bathrooms[short_name]["name"]} is occupied."
  end
end

def short_name
  return if params["text"].nil?
  params["text"].downcase
end

def bathrooms
  settings.bathrooms
end

def open_icon
  ':' + settings.open.sample + ':'
end

def closed_icon
  ':' + settings.closed.sample + ':'
end
