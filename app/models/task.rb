class Task < ActiveRecord::Base
  belongs_to :user
  validate :check_user_availability
  validates :starttime, presence: true
  validates :endtime, presence: true
  # before_save :weekend_check

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

  def project_link(name)
    Redminer.redmine_link(name)
  end

  def task_overdue
    self.endtime < Date.today && self.done != true
  end

  private

  def check_user_availability
    id = self.assignee
    timerange = (self.starttime.to_datetime..self.endtime.to_datetime)
    User.find_by_id(id).alltasks.each do |task|
      timerange_user = task.starttime.to_datetime..task.endtime.to_datetime
      if task.id != self.id
        if timerange_user.overlaps?(timerange)
          errors.add(:user, "is busy. Change start and end time for the task")
          return false
        end
      end
    end
    return true
  end



  def weekend_check
    timerange = (self.starttime.to_datetime..self.endtime.to_datetime)
    self.endtime = self.endtime + timerange.find_all{|date| [0, 6, 7].include?(date.wday)}.count.day
  end
end
