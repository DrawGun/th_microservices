require_relative '../models/ad'

Ad.destroy_all
Ad.create([
  { city: 'City 1', title: 'Title 1', description: 'Description 1', user_id: 1 },
  { city: 'City 2', title: 'Title 2', description: 'Description 2', user_id: 2 },
  { city: 'City 3', title: 'Title 3', description: 'Description 3', user_id: 1 },
  { city: 'City 4', title: 'Title 4', description: 'Description 4', user_id: 2 },
  { city: 'City 5', title: 'Title 5', description: 'Description 5', user_id: 1 },
])
