# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.transaction do
  Company.find_or_create_by_key!(key: 'O12', name: 'Origin12')

  activities = [
    {
      description: '100% Probability',
      display_order: 10,
      color: '#FFF',
      background_color: 'Green'
    },
    {
      description: '90% Probability',
      display_order: 20,
      color: '#FFF',
      background_color: 'DarkTurquoise'
    },
    {
      description: '50% Probability',
      display_order: 30,
      color: '#000',
      background_color: 'Yellow'
    },
    {
      description: '10% Probability',
      display_order: 40,
      color: '#FFF',
      background_color: 'FireBrick'
    },
    {
      description: 'Planned Bench',
      display_order: 50,
      color: '#FFF',
      background_color: 'Grey'
    },
    {
      description: 'Unplanned Bench',
      display_order: 60,
      color: '#FFF',
      background_color: 'Red',
      default: true
    },
    {
      description: 'Non-Working Day',
      display_order: 70,
      color: '#FFF',
      background_color: 'Grey'
    },
    {
      description: 'Sick Leave',
      display_order: 80,
      color: '#FFF',
      background_color: 'DeepSkyBlue '
    },
    {
      description: 'Time Off in Lieu',
      display_order: 90,
      color: '#FFF',
      background_color: 'DeepSkyBlue '
    },
    {
      description: 'Annual Leave',
      display_order: 100,
      color: '#FFF',
      background_color: 'DeepSkyBlue '
    }
  ]

  activities.each do |activity|
    Activity.find_or_create_by_description! activity
  end

end
