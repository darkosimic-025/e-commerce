Admin.find_or_create_by!(email: 'admin@example.com') do |admin|
  admin.password = 'password123'
  admin.password_confirmation = 'password123'
end

