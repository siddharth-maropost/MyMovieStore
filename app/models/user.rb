class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  mount_uploader :image, UserUploader
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2]


  has_many :comments, dependent: :destroy
  has_many :movies, through: :comments

  validates_presence_of :name


  after_create :send_admin_mail
  def send_admin_mail
    UserMailer.welcome_email(self).deliver_now
  end

  # after_update :send_edit_mail
  # def send_edit_mail
  #   UserMailer.edit_email(self).deliver_now
  # end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
    #Uncomment the section below if you want users to be created if they don't exist
    unless user
        user = User.create(name: data['name'],
           email: data['email'],
           password: Devise.friendly_token[0,20],
           remote_image_url: data['image']
        )
    end
    user
end

end
