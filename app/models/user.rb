class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  def full_name
    first_name + " " + last_name
  end

  has_many :statuses
  accepts_nested_attributes_for :statuses
end
