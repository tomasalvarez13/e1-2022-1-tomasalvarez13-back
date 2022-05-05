# frozen_string_literal: true

json.locations(@locations) do |location|
  json.lat location.lat
  json.long location.long
  json.id location.id
end
json.u_id @user_id
