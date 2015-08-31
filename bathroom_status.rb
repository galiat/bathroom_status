require 'sinatra'

configure do
  set :bathrooms, {
    'baltar' => 'The Dave Baltar Lifetime Achievement Bathroom',
    '125' => '125'
  }
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
  # :thumbsdown:
  # :+1:
  # :toilet
  # :poop:
  ":poop: #{bathrooms[short_name]} is open for business."
end

def short_name
  return if params[:text].nil?
  params[:text].downcase
end

def bathrooms
  settings.bathrooms
end
