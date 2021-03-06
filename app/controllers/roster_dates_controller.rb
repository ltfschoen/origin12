class RosterDatesController < ApplicationController

  before_filter :require_user

  before_filter :build_default_roster_date, only: [ :new, :edit ]

  before_filter :build_roster_date, only: [ :create ]

  rescue_from ActiveRecord::RecordNotFound do
    redirect_to roster_path
  end

  def index
    respond_to do |format|
      format.html
      format.json { render json: roster_dates }
    end
  end

  # def show
  #   @roster_date = RosterDate.find(params[:id])
  #   respond_to do |format|
  #     format.html # show.html.erb
  #     format.json { render json: @roster_date }
  #   end
  # end

  def new
    respond_to do |format|
      format.html
      format.json { render json: roster_date }
    end
  end

  def create
    respond_to do |format|
      if current_company.roster_dates.push(roster_date)
        roster_date.duplicate(*params[:wday])
        format.html { redirect_to_rosters_dates_or_schedule_rates }
        format.json { render json: roster_date, status: :created, location: roster_date }
      else
        format.html { render action: "new" }
        format.json { render json: roster_date.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if roster_date.update_attributes(params[:roster_date])
        roster_date.duplicate(*params[:wday])
        format.html { redirect_to_rosters_dates_or_schedule_rates }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: roster_date.errors, status: :unprocessable_entity }
      end
    end
  end

  def duplicate
    respond_to do |format|
      if RosterDate.duplicate employee, current_company, params[:duplicate]
        format.html do
          path = current_employee.role?('admin') ? (employee_roster_dates_path employee) : roster_dates_path
          redirect_to path, notice: 'Roster week was successfully duplicated.'
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { head :status, :unprocessable_entity }
      end
    end
  end

  # def destroy
  #   @roster_date = RosterDate.find(params[:id])
  #   @roster_date.destroy
  #   respond_to do |format|
  #     format.html { redirect_to roster_dates_url }
  #     format.json { head :no_content }
  #   end
  # end

private

  helper_method \
      :employee,
      :roster_dates,
      :roster_date,
      :duplicate_date

  def employee
    @employee ||= begin
      if current_employee.role?('admin') && params[:employee_id]
        current_company.employees.find(params[:employee_id])
      else
        current_employee
      end
    end
  end

  def roster_dates
    @roster_dates ||= begin
      employee.roster_dates.
        company(current_company).
        includes(:rosters).
        default_order.
        merge(Roster.default_order)
    end
  end

  def roster_date
    @roster_date ||= begin
      if params[:id]
        employee.roster_dates.company(current_company).find(params[:id])
      else
        new_roster_date
      end
    end
  end

  def new_roster_date
    date = params[:date] ? Date.parse(params[:date]) : Date.today
    @roster_date = employee.roster_dates.build(date: date)
  end

  def build_roster_date
    @roster_date = roster_dates.build(params[:roster_date])
  end

  def build_default_roster_date
    roster_date.build_default_rosters
  end

  def duplicate_date
    @duplicate_date ||= Date.parse(params[:date])
  end

  ###

  def redirect_to_rosters_dates_or_schedule_rates
    project_id = params[:schedule_rates_project_id]
    if project_id.present?
      session[:return_to_path] = edit_roster_date_path(roster_date)
      redirect_to project_schedule_rates_path(project_id)
    else
      flash[:notice] = "Roster week was successfully #{params[:action]}d."
      redirect_to (current_employee.role?('admin') ? (employee_roster_dates_path employee) : roster_dates_path)
    end
  end

end
