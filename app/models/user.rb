class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, ImageUploader

  enum role: [:normal, :merchant]

  has_many :tickets
  has_many :et_groups
  has_and_belongs_to_many :groups, join_table: 'groups_users'
end
