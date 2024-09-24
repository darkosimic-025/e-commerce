require 'faker'

Admin.find_or_create_by!(email: 'admin@example.com') do |admin|
  admin.password = 'password123'
  admin.password_confirmation = 'password123'
end

Book.destroy_all
Genre.destroy_all

genres = []
10.times do
  genre_name = Faker::Book.unique.genre
  genres << Genre.create!(name: genre_name, description: Faker::Lorem.sentence)
end

genres.each do |genre|
  10.times do
    Book.create!(
      title: Faker::Book.title,
      author: Faker::Book.author,
      price: Faker::Commerce.price(range: 10.0..100.0),
      description: Faker::Lorem.paragraph,
      published_date: Faker::Date.between(from: 50.years.ago, to: Date.today),
      isbn: Faker::Code.isbn,
      stock_quantity: rand(1..50),
      cover_image: Faker::LoremFlickr.image(size: "300x400", search_terms: ['book']),
      genre: genre
    )
  end
end