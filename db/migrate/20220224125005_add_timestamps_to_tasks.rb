class AddTimestampsToTasks < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :tasks, null: false
  end
end
