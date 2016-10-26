class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, :omniauth_providers => [:facebook,:google_oauth2,:twitter]

  has_many :questions
  has_many :contests
  has_many :causes
  has_many :articles

  has_many :answers
  has_many :contest_answers
  has_many :cause_comments
  has_many :article_requests

  has_many :replies
  has_many :cause_replies

  has_many :notifications

  # Uploader
  mount_uploader :profile_pic, ProfilePicUploader

  # Profile info
  serialize :education
  serialize :interests
  serialize :knows_about
  serialize :employments

  # Questions
  serialize :following
  
  # Answers
  serialize :answers_upvote
  serialize :answers_downvote

  # Causes
  serialize :causes_agreed
  serialize :causes_disagreed
  serialize :causes_followed

  # For Omniauth
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.find_for_omniauth(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(name: data["name"],
         email: data["email"],
         password: Devise.friendly_token[0,20]
      )
    end
    user
  end

protected
  def confirmation_required?
    false
  end
end
