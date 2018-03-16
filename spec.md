# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app - required sinatra and utilized framework.
- [x] Use ActiveRecord for storing information in a database - created models and used ActiveRecord to store user information, restaurants and a join table of information between the user and restaurant model for bookmarking restaurants.
- [x] Include more than one model class (list of model class names e.g. User, Post, Category) - Used models for Users, Restaurants and Bookmarks.
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts) - User has many restaurants, Restaurants has many users, a join table for the both, to create a function of Bookmarks. Used aliasing to accomplish this in the user/restaurant classes.
- [x] Include user accounts - Users can create an account, add restaurants and bookmark restaurants, along with the other RUD of CRUD.
- [x] Ensure that users can't modify content created by other users - users do not have access to edit or delete information that they did not create. There is authentication and checking to see if user is a creator before anything is completed. Helper methods were utilized to verify this info.
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying - This is done in the bookmarks. The CRU is also done in restaurants, but instead of being able to delete a restaurant a user can remove themself as the creator. I did not want a user to be able to delete a restaurant from the database in case someone else bookmarked the restaurant.
- [x] Include user input validations - Validations were added to verify that forms were complete and no input fields were left blank. If they were blank the form pages were rendered again. There also is user validations for username and password validations.
- [x] Display validation failures to user with error message (example form URL e.g. /posts/new) - utilized Rack flash for messages page when user input failed to meet requirements, along with confirmations for success.
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code.

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
