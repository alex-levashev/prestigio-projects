class Task < ActiveRecord::Base
  belongs_to :user
  validate :check_user_availability
  before_save :weekend_check

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

  private

  def check_user_availability
    id = self.assignee
    timerange = (self.starttime.to_datetime..self.endtime.to_datetime)
    User.find_by_id(id).alltasks.each do |task|
      timerange_user = task.starttime.to_datetime..task.endtime.to_datetime
      if timerange_user.include?(timerange)
        errors.add(:user, "is busy. Change start and end time for the task")
        return false
      end
    end
    return true
  end

  def weekend_check
    timerange = (self.starttime.to_datetime..self.endtime.to_datetime)
    byebug
    self.endtime = self.endtime + timerange.find_all{|date| [0, 6, 7].include?(date.wday)}.count.day
  end
end
