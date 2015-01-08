class UserInfo < ActiveRecord::Base
  validates :user_id, presence: true
  belongs_to :user
  has_one :address, as: :addressable, class_name: 'Adress'
  accepts_nested_attributes_for :address

  before_create :set_student

  def set_student
    self.is_student = true if is_student.nil? and user.student_email_valid?
  end
end
