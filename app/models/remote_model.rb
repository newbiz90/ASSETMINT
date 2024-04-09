# This RemoteModel class is used to create a model that doesn't have a database table. 
# This is useful when we want to create a model that doesn't have a database table, like the API response in this case.

# The ActiveModel::Model gives us the ability to use ActiveModel features without the need for a database table.
# One such feature is that we no longer need to create a constructor method to initialize the object with its attributes.

class RemoteModel
    include ActiveModel::Model
end