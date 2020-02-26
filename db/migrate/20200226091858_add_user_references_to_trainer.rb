class AddUserReferencesToTrainer < ActiveRecord::Migration[6.0]
  def change
    add_reference :trainers, :user, null: true, foreign_key: true
  end
end
