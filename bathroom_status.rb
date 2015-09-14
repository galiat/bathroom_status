require 'sinatra'

configure do
  set :bathrooms,
  {
    baltar:
      { name: 'The Dave Baltar Lifetime Achievement Bathroom',
        status: 'closed'
      }
  }

  set :open, %w{ simple_smile +1 toilet poop ghost }
  set :closed, %w{ thumbsdown heavy_exclamation_mark warning non-potable_water no_entry }
end

get '/' do
  if !params.has_key?(:text) || params[:text].empty?
    availability(:baltar)
  elsif bathrooms[short_name.to_sym]
    availability(short_name)
  else
    "I don't know that bathroom. Try #{bathrooms.keys.join(' or ')}"
  end
end

post '/update' do
  # hard code baltar for right now
  settings.bathrooms[:baltar][:status] = params[:status]
end

def availability(short_name)
  if settings.bathrooms[short_name][:status] == 'open'
    "#{open_icon} #{settings.bathrooms[short_name][:name]} is open for business."
  else
    "#{closed_icon} #{settings.bathrooms[short_name][:name]} is occupied."
  end
end

def short_name
  return if params[:text].nil?
  params[:text].downcase
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


