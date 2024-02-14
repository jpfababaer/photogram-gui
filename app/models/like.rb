# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  fan_id     :integer
#  photo_id   :integer
#

class Like < ApplicationRecord
  validates(:fan, { :presence => true }) #Fan column must be inputted
  validates(:photo, { :presence => true }) #Photo column must be inputted
  validates(:photo_id, { 
    :uniqueness => { :scope => [:fan_id] } #The photo_id column must have a unique fan_id
  })

  #1 Self = a fan (i.e. follower). This returns an Instance of a User (who is a fan).
  def fan
    my_fan_id = self.fan_id

    matching_users = User.where({ :id => my_fan_id })

    the_user = matching_users.at(0)

    return the_user
  end

  #2 Self = a specific photo. This returns a Instance of a photo. SEARCH follow_request.rb
  def photo
    my_photo_id = self.photo_id

    matching_photos = Photo.where({ :id => my_photo_id })

    the_photo = matching_photos.at(0)

    return the_photo
  end
end
