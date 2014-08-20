class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  def full_name
    first_name + " " + last_name
  end

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :profile_name, presence: true,
                           uniqueness: true,
                           format: {
                           	with: /\A[a-zA-Z0-9_-]+\z/,
                           	message: 'Must be formatted correctly.'
                           }

  has_many :statuses
  accepts_nested_attributes_for :statuses
end
