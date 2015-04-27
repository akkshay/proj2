class Link < ActiveRecord::Base
	validates :url, presence: true
	validates :points, presence: true
	validates :user_id, presence: true
	belongs_to :user
end
