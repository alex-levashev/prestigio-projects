class Task < ActiveRecord::Base
  belongs_to :user
  
  def author_from_id_to_name
    id = self.user_id
    user = User.find_by_id(id)
    user.first_name + " " + user.last_name
  end
  
  def assignee_from_id_to_name
    id = self.assignee
    user = User.find_by_id(id)
    user.first_name + " " + user.last_name
  end
  
  def check_user_availability
    id = self.assignee
    timerange = (self.starttime..self.endtime)
    User.find_by_id(id).alltasks.each do |task|
      timerange_user = task.starttime..task.endtime
      return true if timerange_user.include?(timerange)
    end
    return false
  end
end
