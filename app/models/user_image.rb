class UserImage < ApplicationRecord
	has_one_attached :pic
	belongs_to :user
end
