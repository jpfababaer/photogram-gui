class UsersController < ApplicationController

  def index
    matching_users = User.all
    @list_of_users = matching_users.order({ username: :asc})

    render({template: "users_template/index"})
  end

  def show
    url_username = params.fetch("path_username")
    matching_usernames = User.where({username: url_username})

    @the_user = matching_usernames.first

    render({template: "users_template/show"})
  end

  def create
    new_user = User.new

    new_user.username = params.fetch("username_info")

    new_user.save

    redirect_to("/users/#{new_user.username}")
  end

  def update
    user_id = params.fetch("path_id")
    
    matching_user = User.where({ id: user_id})
    @the_user = matching_user.at(0)

    @the_user.username = params.fetch("username_info")

    @the_user.save

    redirect_to("/users/#{@the_user.username}")
  end


end
