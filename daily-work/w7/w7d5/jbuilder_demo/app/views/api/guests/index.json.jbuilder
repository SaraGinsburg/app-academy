json.array! @guests do |guest|
  json.partial! 'guest', locals: {guest: guest} if guest.age.between?(40,50)
end
