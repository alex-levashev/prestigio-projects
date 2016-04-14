class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tasks, dependent: :destroy
  scope :activated, -> { where(activated: true) }
  # validates :password, presence: true, on: :create

  def alltasks
    user = self.id
    Task.where(:assignee => user)
  end

end
