module EmployeesHelper

  ROSTER_HEIGHT = 30

  def roster_dates_group_by_beginning_of_week
    @roster_dates_group_by_beginning_of_week ||= begin
      date_range = rosters_start_date..rosters_end_date
      group_dates = date_range.inject([]) do |memo, date|
        date_as_related = [ date.beginning_of_week(:sunday), date ]
        memo << date_as_related
      end.group_by(&:first)

      group_dates.merge group_dates do |beginning_of_week, related_dates|
        related_dates.map(&:last)
      end
    end
  end

  def wday_class(date)
    { class: "wday_#{date.strftime '%w'}" }
  end

  def employee_roster_date(employee, date)
    employee.roster_dates.detect do |roster_date|
      roster_date.date == date
    end
  end

  def class_for(roster, total_hours)
    (activity_class roster.activity).merge(roster_height roster, total_hours)
  end

  def title_for(roster)
    { title: roster.project.customer.display_name }
  end

private

  def activity_class(activity)
    { class: "activity_#{activity[:id]}" }
  end

  def roster_height(roster, total_hours)
    hours = roster.hours || 0
    if total_hours > RosterDate::HOURS_PER_DAY
      hours = hours / total_hours * RosterDate::HOURS_PER_DAY
    end
    { style: "height:#{hours / RosterDate::HOURS_PER_DAY * ROSTER_HEIGHT}px" }
  end

end
