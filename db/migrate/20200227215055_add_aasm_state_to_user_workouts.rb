class AddAasmStateToUserWorkouts < ActiveRecord::Migration[6.0]
  def change
    add_column :user_workouts, :aasm_state, :string
  end
end
