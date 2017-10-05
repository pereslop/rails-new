# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  username               :string
#  role                   :integer          default("user")
#

class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  validates_integrity_of  :avatar
  validates_processing_of :avatar

  ROLES = [:user, :admin]

  has_many :posts, dependent: :destroy

  enum role: ROLES

  validates :username,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { minimum: 3 }

  scope :ordered, -> { order(username: :asc) }

  acts_as_liker
end
