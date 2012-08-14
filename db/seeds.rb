ActiveRecord::Base.transaction do

  origin12 = Company.find_or_create_by_key! \
      key: 'O12',
      name: 'Origin12'

  user_role  = Role.find_or_create_by_key! \
      key: 'user',
      name: 'User',
      default: true

  admin_role = Role.find_or_create_by_key! \
      key: 'admin',
      name: 'Admin',
      parent_id: user_role[:id]

  root_role  = Role.find_or_create_by_key! \
      key: 'root',
      name: 'Root',
      parent_id: admin_role[:id]

  root = User.find_or_initialize_by_email \
      email: 'root@origin12.com',
      password: 'root',
      password_confirmation: 'root',
      employee_attributes: { first_name: nil, last_name: 'root'}

  root.employee.key = 'ROOT'
  root.employee.role = root_role
  root.save(validate: false)

  unless root.companies.include? origin12
    root.companies << origin12
  end

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
