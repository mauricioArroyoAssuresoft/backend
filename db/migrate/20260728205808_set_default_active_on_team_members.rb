class SetDefaultActiveOnTeamMembers < ActiveRecord::Migration[8.1]
  def change
    change_column_default :team_members, :active, from: nil, to: true
    change_column_null :team_members, :active, false
  end
end
