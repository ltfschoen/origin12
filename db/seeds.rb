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

  cross_company_role = Role.find_or_create_by_key! \
      key: 'cross_company',
      name: 'Cross Company',
      parent_id: admin_role[:id]

  root_role  = Role.find_or_create_by_key! \
      key: 'root',
      name: 'Root',
      parent_id: cross_company_role[:id]

  ###

  root_employee = Employee.find_or_initialize_by_key \
      key: 'ROOT',
      email: 'root@origin12.com',
      first_name: 'root',
      last_name: 'root'

  root_employee.role = root_role
  root_employee.save!

  unless root_employee.companies.include? origin12
    root_employee.companies << origin12
  end

  root_user = User.find_or_initialize_by_email \
      email: 'root@origin12.com',
      password: 'root',
      password_confirmation: 'root'

  root_user.employee = root_employee
  root_user.save!

  ###

  activities = [
    {
      key: 'one_hundred_percent',
      description: '100% Probability',
      display_order: 10,
      color: '#FFF',
      background_color: 'Green'
    },
    {
      key: 'ninety_percent',
      description: '90% Probability',
      display_order: 20,
      color: '#FFF',
      background_color: 'DarkTurquoise'
    },
    {
      key: 'fifty_percent',
      description: '50% Probability',
      display_order: 30,
      color: '#000',
      background_color: 'Yellow'
    },
    {
      key: 'ten_percent',
      description: '10% Probability',
      display_order: 40,
      color: '#FFF',
      background_color: 'FireBrick'
    },
    {
      key: 'planned_bench',
      description: 'Planned Bench',
      display_order: 50,
      color: '#FFF',
      background_color: 'Grey'
    },
    {
      key: 'unplanned_bench',
      description: 'Unplanned Bench',
      display_order: 60,
      color: '#FFF',
      background_color: 'Red',
      default: true
    },
    {
      key: 'nonworking_day',
      description: 'Non-Working Day',
      display_order: 70,
      color: '#FFF',
      background_color: '#EEE'
    },
    {
      key: 'sick_leave',
      description: 'Sick Leave',
      display_order: 80,
      color: '#FFF',
      background_color: 'DeepSkyBlue '
    },
    {
      key: 'time_off_in_lieu',
      description: 'Time Off in Lieu',
      display_order: 90,
      color: '#FFF',
      background_color: 'DeepSkyBlue '
    },
    {
      key: 'annual_leave',
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
