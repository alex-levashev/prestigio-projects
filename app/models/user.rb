class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :tasks, dependent: :destroy
  scope :activated, -> { where(activated: true) }

  validates :email, presence: true
  validates :first_name, uniqueness: { scope: :last_name,
    message: " and last name combinations exists already!" }
  validates :role, presence: true

  # validates :password, presence: true, on: :create

  def alltasks
    user = self.id
    Task.where(:assignee => user)
  end

end
