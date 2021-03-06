Origin12::Application.routes.draw do

  resources :roles

  resources :companies, only: [ :index, :new, :create, :edit, :update ] do
    collection { get :switch }
  end

  resources :customers, only: [ :index, :new, :create, :edit, :update ] do
    resources :projects, only: [ :index, :new, :edit ]
  end

  resources :teams, except: [ :show ]

  resources :employees, except: [ :show ] do
    collection { get :switch }
    collection { get :rosters, :action => 'index', view: 'rosters' }
    resources :roster_dates, only: [ :index, :new, :create, :edit, :update ] do
      collection do
        get  :copy
        post :copy, action: 'duplicate'
      end
    end
  end

  # AJAX get a collection of projects
  resources :projects, only: [ :index, :new, :create, :update ] do
    resources :schedule_rates, only: [ :index, :new, :create ]
  end

  resources :roster_dates, :controller => 'roster_dates'

  # To duplication a week of roster dates
  # get  'roster_dates/:duplicate_date/copy' => 'roster_dates#copy', as: 'copy_roster_date'
  # post 'roster_dates/duplicate' => 'roster_dates#duplicate', as: 'copy_roster_dates'

  # Human-readable shortcut to current_employee's roster date
  get 'roster' => 'roster_dates#index'

  # resources :activities

  resource :session, controller: 'user_session', only: [ :new, :create, :destroy ]

  get 'login'  => 'user_session#new'
  get 'logout' => 'user_session#destroy'

  resources :users, except: [ :destroy ]

  root :to => 'roster_dates#index'

end
