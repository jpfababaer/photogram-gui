#NOTES -> Notes start at like.rb

Rails.application.routes.draw do

  get("/", {controller: "users", action: "index"})

  #-----------------------------------------
  #Users page:

  #10 Conventional naming: name the controller after the Table - plural = users. When name an action that LISTS things -> "index"
  get("/users", {controller: "users", action: "index"})
  get("/users/:path_username", {controller: "users", action: "show"})

  #-----------------------------------------
  #Photos page:
  get("/photos", {controller: "photos", action: "index"})
  get("/photos/:path_id", {controller: "photos", action: "show"})
  get("/delete_photo/:path_id", {controller: "photos", action: "destroy"})
  post("/update_photo/:path_id", controller: "photos", action: "update")
  post("/insert_photo_record", controller: "photos", action: "create")
  post("/add_comment", controller: "photos", action: "comment")

end
