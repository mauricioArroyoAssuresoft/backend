class CreateTeamMembers < ActiveRecord::Migration[8.1]
  def change
    create_table :team_members do |t|
      t.string :name
      t.string :email
      t.string :role
      t.boolean :active

      t.timestamps
    end
  end
end
