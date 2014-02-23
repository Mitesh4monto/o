class AddTimingUntilToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :timing_until, :date
  end
end
