json.locations(@locations) do |location|
    json.lat location.lat
    json.long location.long
end
json.other_locations(@other_location_list) do |other_location|
    json.location other_location
end