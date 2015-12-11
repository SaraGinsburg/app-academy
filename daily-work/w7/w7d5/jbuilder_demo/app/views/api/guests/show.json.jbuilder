json.partial! 'guest', locals: {guest: @guest}

json.gifts do
  json.array! @guest.gifts, :title, :description
end
