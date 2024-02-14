class PhotosController < ApplicationController

  def index

    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ created_at: :desc})

    render({template: "photos_template/index"})
  end

  
  def show
    photo_id = params.fetch("path_id")

    matching_photo = Photo.where({id: photo_id})
    @the_photo = matching_photo.first

    render({template: "photos_template/show"})
  end

  def destroy
    photo_id = params.fetch("path_id")

    matching_photo = Photo.where({ :id => photo_id })
    
    the_photo = matching_photo.at(0) 

    the_photo.destroy

    redirect_to("/photos")
  end

  def update
    photo_id = params.fetch("path_id")

    matching_photo = Photo.where(id: photo_id)

    the_photo = matching_photo.at(0)

    the_photo.image = params.fetch("image_info")
    the_photo.caption = params.fetch("caption_info")

    the_photo.save

    redirect_to("/photos/#{the_photo.id}")
  end

  def create
    new_photo = Photo.new

    new_photo.image = params.fetch("image_info")
    new_photo.caption = params.fetch("caption_info")
    new_photo.owner_id = params.fetch("owner_id_info")

    new_photo.save

    redirect_to("/photos/#{new_photo.id}")

  end

  def comment 
    new_comment = Comment.new
    
    new_comment.photo_id = params.fetch("photo_id_info")
    new_comment.author_id = params.fetch("author_id_info")
    new_comment.body = params.fetch("comment_info")

    new_comment.save

    redirect_to("/photos/#{new_comment.photo_id}")
  end

end
