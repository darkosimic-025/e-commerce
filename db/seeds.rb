require 'faker'

puts "Deleting old records..."
Book.destroy_all
Genre.destroy_all
Admin.destroy_all

Admin.find_or_create_by!(email: 'admin@example.com') do |admin|
  admin.password = 'password123'
  admin.password_confirmation = 'password123'
end

puts "Seeding genres..."
genres = []
10.times do
  genre_name = Faker::Book.unique.genre
  genres << Genre.create!(name: genre_name, description: Faker::Lorem.sentence)
end

def attach_image(book)
  if Rails.env.production?
    book.image.attach(io: File.open(Rails.root.join('app/assets/images/red_book.jpg')), filename: 'red_book.jpg', content_type: 'image/jpg')
  else
    book.image.attach(io: File.open(Rails.root.join('app/assets/images/red_book.jpg')), filename: 'red_book.jpg', content_type: 'image/jpg')
  end
end

puts "Seeding books..."
genres.each do |genre|
  10.times do
    book = Book.create!(
      title: Faker::Book.title,
      author: Faker::Book.author,
      price: Faker::Commerce.price(range: 10.0..100.0),
      description: Faker::Lorem.paragraph,
      published_date: Faker::Date.between(from: 50.years.ago, to: Date.today),
      isbn: Faker::Code.isbn,
      stock_quantity: rand(1..50),
      genre: genre
    )

    attach_image(book)
  end
end

puts "Seeding complete!"
