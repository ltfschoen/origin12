class CompaniesController < ApplicationController

  before_filter :require_admin

  def index
    respond_to do |format|
      format.html
      format.json { render json: companies }
    end
  end

  def switch
    respond_to do |format|
      current_company company
      format.html { redirect_to request.referer }
      format.json { render json: company }
    end
  end

  # def show
  #   respond_to do |format|
  #     format.html
  #     format.json { render json: company }
  #   end
  # end

  def new
    respond_to do |format|
      format.html
      format.json { render json: company }
    end
  end

  def create
    respond_to do |format|
      if company.save
        format.html { redirect_to companies_path, notice: 'Company was successfully created.' }
        format.json { render json: company, status: :created, location: company }
      else
        format.html { render action: "new" }
        format.json { render json: company.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if company.update_attributes(params[:company])
        format.html { redirect_to companies_path, notice: 'Company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: company.errors, status: :unprocessable_entity }
      end
    end
  end

private

  helper_method :companies, :company

  def companies
    @companies ||= Company.includes(:parent)
  end

  def company
    @company ||= begin
      params[:id] ? companies.find(params[:id]) : new_company
    end
  end

  ###

  def new_company
    Company.root.children.build(params[:company]).tap do |company|
      company.company_employees.build(employee_id: current_employee[:id])
    end
  end

end
