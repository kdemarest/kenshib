class Authorization < ActiveRecord::Base
	attr_accessible :provider, :uid, :user_id
	belongs_to :user
	validates :provider, :uid, :presence => true

	def self.find_or_create(auth_hash)
		unless auth = find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])

			name = auth_hash["info"]["nickname"]
			email = auth_hash["info"]["email"]
			if email == nil
				email = name+"@test.com"
			end

			logger.debug "KD: user=" + name.inspect + " email="+email.inspect
			logger.debug "KD: provider=" + auth_hash["provider"].inspect + " uid="+auth_hash["uid"]


			user = User.create :name => name, :email => email

			logger.debug "KD: user data = "+user.inspect
			auth = create :user_id => user.id, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
		end
		auth
	end
end
