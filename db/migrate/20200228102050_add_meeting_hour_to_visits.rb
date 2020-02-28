class AddMeetingHourToVisits < ActiveRecord::Migration[6.0]
  def change
    add_column :visits, :meeting_hour, :time
  end
end
