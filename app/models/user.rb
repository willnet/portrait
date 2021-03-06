class User < ActiveRecord::Base
	has_many :created_posts,class_name 'Post', foreign_key :owner_id
	has_many :tickets, dependent: :nullify
    has_many :participating_events, through: :tickets, source: :even

	def self.find_or_create_from_auth_hash(auth_hash)
	    provider = auth_hash[:provider]
	    uid = auth_hash[:uid]
	    nickname = auth_hash[:info][:nickname]
	    image_url = auth_hash[:info][:image]

    User.find_or_create_by(provider: provider, uid: uid) do |user|
      user.nickname = nickname
      user.image_url = image_url
      end
    end
end
