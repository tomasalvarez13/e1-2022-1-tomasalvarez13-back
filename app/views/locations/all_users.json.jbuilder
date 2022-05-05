json.users(@users) do |user|
    json.email user.email
    json.nickname user.nickname
end