require 'sinatra'

configure do
  set :bathrooms, {
    'baltar' => 'The Dave Baltar Lifetime Achievement Bathroom',
    '125' => '125'
  }

  set :open, %w{ simple_smile +1 toilet poop ghost }
  set :closed, %w{ thumbsdown heavy_exclamation_mark warning non-potable_water no_entry }

end

get '/' do
  if params[:text].empty?
    availability('baltar')
  elsif bathrooms[short_name]
    availability(short_name)
  else
    "I don't know that bathroom. Try #{bathrooms.keys.join(' or ')}"
  end
end


def availability(short_name)
  if short_name == 'baltar'
    "#{open_icon} #{bathrooms[short_name]} is open for business."
  else
    "#{closed_icon} #{bathrooms[short_name]} is occupied."
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


