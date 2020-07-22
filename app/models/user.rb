class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable , :omniauth_providers => [:facebook]
    
    def self.from_omniauth(auth)
        where(provider: auth[:provider], uid:auth[:uid]).first_or_create do |user|
            if auth[:info]
                user.email = auth[:info][:email]
                user.name = auth[:info][:email]
            end
            user.password = Devise.friendly_token[0,20]
        end
    end
    
end

# Facebook Settings
=begin
def self.find_for_facebook_oauth(auth, signed_in_resource = nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    if user.present?
        user
    else
        user = User.create(first_name:auth.extra.raw_info.first_name,
                                             last_name:auth.extra.raw_info.last_name,
                                             facebook_link:auth.extra.raw_info.link,
                                             user_name:auth.extra.raw_info.name,
                                             provider:auth.provider,
                                             uid:auth.uid,
                                             email:auth.info.email,
                                             password:Devise.friendly_token[0,20])
    end
end
=end