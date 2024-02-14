# == Schema Information
#
# Table name: photos
#
#  id             :integer          not null, primary key
#  caption        :text
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :integer
#

class Photo < ApplicationRecord
  validates(:poster, { :presence => true })

  #4 Takes in a Photo instance -> and uses the ownwer_id to return the Instance of a User who OWNS the post. 
  def poster
    matching_users = User.where({ :id => self.owner_id })

    the_user = matching_users.at(0)

    return the_user
  end

  #5 Takes in a Photo instance -> uses the Photo instance's id (PK) and queries the "Comment" database of ALL Comment instances that HAS the attribute "photo_id" == id (PK of Photo Instance) then returns the ARR of matching instances.
  def comments

    matching_comments = Comment.where({ :photo_id => self.id })

    return matching_comments
  end

  #6 Takes in a Photo instance -> uses the Photo instance's id (PK) and queries the "Like" database of all Like instances that HAS the attribute "photo_id" == id (PK of Photo Instance) then returns the ARR of matching instances.
  def likes
    matching_likes = Like.where({ :photo_id => self.id })

    return matching_likes
  end

  #7 Takes in a Photo instance -> uses the Photo instance's id (PK, via "likes" method). "likes" returns the ARR of matching instances for whoever likes the photo and plucks plucks the fan_id attribute = determines the User instances who liked the Photo instance. 
  def fans
    user_ids = self.likes.pluck(:fan_id) #Pluck selects SPECIFIC attributes defined in the parameter and returns its values in an Array
    matching_users = User.where({ :id => user_ids }) #User_ids is an Array of user_ids that liked the Photo instance. When placed inside of .where(), it iterates through all elements to create a new ARR. 

    return matching_users
  end

  #8 SEARCH comment.rb
  def fan_list
    my_fans = self.fans

    array_of_usernames = Array.new

    my_fans.each do |a_user|
      array_of_usernames.push(a_user.username)
    end

    formatted_usernames = array_of_usernames.to_sentence

    return formatted_usernames
  end
end
