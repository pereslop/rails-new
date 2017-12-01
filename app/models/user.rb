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
#  role                   :integer          default("user,")
#  username               :string
#  avatar                 :string
#  followees_count        :integer          default(0)
#  followers_count        :integer          default(0)
#

class User < ApplicationRecord
  ROLES = %i(user, admin)
  SOCIALS = {
      facebook: 'Facebook',
      google_oauth2: 'Google'
  }

  mount_uploader :avatar, AvatarUploader

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :authorizations, dependent: :destroy

  acts_as_liker
  acts_as_followable
  acts_as_follower

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: SOCIALS.keys

  validates_integrity_of  :avatar
  validates_processing_of :avatar
  validates :username,
    presence: true,
    uniqueness: { case_sensitive: false },
    length: { minimum: 3 }

  enum role: ROLES

  scope :ordered, -> { order(username: :asc) }

  def self.from_omniauth(auth)
    authorization = Authorization.where(provider: auth[:provider], uid: auth[:uid].to_s).first_or_create
    if authorization.user.blank?
      user = User.find_by(email: auth[:info][:email])
      if user.blank?
        user = User.new
        user.password = Devise.friendly_token[0, 20]
        user.fetch_details(auth)
        user.save
      end
      authorization.user = user
      authorization.save
    end
    authorization.user
  end

  def fetch_details(auth)
    self.username = auth[:info][:name]
    self.email = auth[:info][:email]
    self.remote_avatar_url = auth[:info][:image]
  end

end
