# == Schema Information
#
# Table name: team_projects
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  permission_id :integer
#  space_id      :integer
#  project_id    :integer
#  user_team_id  :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

##
# Team project model
#
class TeamProject < ActiveRecord::Base
  belongs_to :user
  belongs_to :permission

  ##
  # If that user has permission to execute the action over the project
  #
  def self.permission?(current_user, owner_user, permission)
    begin
      permission_id = Permission.find_by! permission: permission
      TeamSpace.find_by! user_id: owner_user, user_team_id: current_user, permission_id: permission_id
    rescue
      return false
    end

    true
  end
end
