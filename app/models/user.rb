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
#  role                   :integer          default("user")
#  username               :string
#  avatar                 :string
#

class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader


  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  # has_many :follows, as: :followable
  # has_many :follows, as: :follower


  acts_as_liker
  acts_as_followable
  acts_as_follower

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  validates_integrity_of  :avatar
  validates_processing_of :avatar
  validates :username,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { minimum: 3 }

  ROLES = [:user, :admin]
  enum role: ROLES

  scope :ordered, -> { order(username: :asc) }

end
