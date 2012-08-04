class EmployeesController < ApplicationController

  before_filter :require_user

  helper_method \
    :employee,
    :employees,
    :rosters_end_date,
    :rosters_start_date

  before_filter :new_employee, only: [ :new, :create ]

  before_filter :build_employee_rates, only: [ :new, :edit ]

  before_filter :set_current_employee, only: [ :switch ]

  after_filter :set_return_to_employees_index, only: [ :index ]

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to employees_path
  end

  def index
    respond_to do |format|
      format.html
      format.json { render json: employees }
    end
  end

  def switch
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.json { render json: company }
    end
  end

# def show
#   respond_to do |format|
#     format.html # show.html.erb
#     format.json { render json: employee }
#   end
# end

  def new
    respond_to do |format|
      format.html
      format.json { render json: employee }
    end
  end

  def create
    respond_to do |format|
      if current_company.employees.push(employee)
        format.html { redirect_to employees_path, notice: 'Employee was successfully created.' }
        format.json { render json: employee, status: :created, location: employee }
      else
        format.html { render action: "new" }
        format.json { render json: employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if employee.update_attributes(params[:employee])
        format.html { redirect_to employees_path, notice: 'Employee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: employee.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url }
      format.json { head :no_content }
    end
  end

private

  def employees
    @employees ||= begin
      current_company.employees.
        includes(roster_dates: { rosters: { project: :customer }}).
        default_order(params[:order]).
        merge(Roster.default_order)
    end
  end

  def employee
    @employee ||= employees.find params[:id]
  end

  def new_employee
    @employee = employees.build(params[:employee])
  end

  def build_employee_rates
    employee.employee_rates.build
  end

  def set_current_employee
    self.current_employee = employee
  end

  def rosters_start_date
    @rosters_start_date ||= Date.today.beginning_of_week :sunday
  end

  def rosters_end_date
    @rosters_end_date ||= begin
      (rosters_start_date + 12.weeks).end_of_week :sunday
    end
  end

  def set_return_to_employees_index
    if params[:rosters]
      session[:return_to_path] = rosters_employees_path
    end
  end

end
