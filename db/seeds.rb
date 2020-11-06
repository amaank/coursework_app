# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Parking space data.

Space.delete_all

# Floor 1: 6 rows, 5 columns (30 spaces)
for i in 1..6 do
  for j in 1..5 do
    Space.create(floor: 1, row: i, column: j)
  end
end

# Floor 2: 6 rows, 6 columns (36 spaces)
for i in 1..6 do
  for j in 1..6 do
    Space.create(floor: 2, row: i, column: j)
  end
end

# Floor 3: 6 rows, 7 columns (42 spaces)
for i in 1..6 do
  for j in 1..7 do
    Space.create(floor: 3, row: i, column: j)
  end
end

# Floor 4: 4 rows, 5 columns (20 spaces)
for i in 1..4 do
  for j in 1..5 do
    Space.create(floor: 4, row: i, column: j)
  end
end

CostType.delete_all

# Cost types data.
CostType.create(name: "Basic", price: 7.5, description: "Our basic parking tier provides you with a traditional parking experience, with no additional services included.")
CostType.create(name: "Standard Valet", price: 12.5, description: "Standard-tier valet takes the stress out of parking your own vehicle, by offering you the services of one of our well-trained staff who will park your car for you, and bring it out to meet you upon your return.")
CostType.create(name: "Advanced Valet", price: 17.5, description: "For those looking to get more out of their everyday park, advanced-tier valet parking offers an external wash of your car, in addition to the standard-tier valet benefits.")
CostType.create(name: "Luxury Valet", price: 22.5, description: "Luxury-tier valet offers you the ultimate parking experience, providing internal cleaning of the car, in addition to the advanced-tier valet benefits.")
