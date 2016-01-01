##
# Team model
#
class Team < ActiveRecord::Base
  belongs_to :user
  belongs_to :permission

  ##
  # If that user has permission to execute the action
  #
  def self.permission?(current_user, owner_user, permission)
    begin
      permission_id = Permission.find_by! permission: permission
      Team.find_by! user_id: owner_user, user_team_id: current_user, permission_id: permission_id
    rescue
      return false
    end

    true
  end
end
