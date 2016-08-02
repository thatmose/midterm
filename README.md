# Summary

Booksharing app where users can post and borrow books from each other.

###Technologies used
* Sinatra (back-end framework)
* Bootstrap (front-end framework)
* SQLite3 (test and development database)
* PostgreSQL (production database)

###Learning outcomes
* Importance of unit testing for edge cases
* Utility of partials to render repetitive views
* RESTful routes
* User authetication
* ERD and database queries

###Stretch goals (if we had more time/ knowledge at the time)
* Implement AJAX for async page updates
* Admin account to oversee users and interactions
* Messaging system within the app to facilitate contact during borrowing transactions


MIDTERM PROJECT
===================
# Outline
Booksharing app Planning 
  - Marketplace app post books for sharing exchange

## USER STORIES
 1 As a user
      I want to list my book to share with others
        because I want to be a part of the booksharing community

  2 As a user 
      I should be able to plan a meeting location
        because I need a way to get loaned books to others

  3 As a user 
      I want to add reviews about the book 
        because reviews are helpful for everyone

  4 As a user 
      I want to share pictures of the book
        because I will be able to see the condition and proof of them having possesion of the book

  Given I'm finished a book
      When I go to post the book
        Then I can post a picture along with the book post
        
## DATABASE TYPE
SQLite3

## ERD

![booksharing_erd](https://cloud.githubusercontent.com/assets/15318273/16848030/1746b21c-49b1-11e6-8969-b6294bfd387a.png)

### Changes!!
  * Changed from current_books to borrowed_books
  * changed relationship between current_books and books to has_one

## ROUTES
* Try to follow RESTful conventions

## WIREFRAMES

<img width="1172" alt="screen shot 2016-07-14 at 9 02 26 am" src="https://cloud.githubusercontent.com/assets/15318273/16848376/c1a71aca-49b2-11e6-9ff7-1118a5d60c95.png">

## GIT WORKFLOW

Please refer to this to get the general idea of how to handle working together

PLEASE NOTE!!
* When you pull from master, you should drop and migrate the database otherwise you might run into errors. We ignore the database when uploading to github so the database needs to be recreated on your machine.
* There is now seed data for users, books,pictures and posts (reviews in this context). After doing your migrations you can run : ``` bundle exec rake db:seed ``` (You get 9 of each with random associations)

* Everyone is a contributor. So you have admin privileges.
* Rule of thumb is to work on a branch and push that branch
```git
  git push origin <your_branchname>
```
* Go onto the github platform where you will see your branch.
* Create a new pull request. If no conflicts are expected (by github and your inspection), go ahead and merge.
* Otherwise, if conflicts exist, please verify with whoever developed the part that you may conflict with before going ahead. If you have good undestanding of the change and are confident of your additions/changes despite the conflict merge and take note of the changes.
* Please test the code to verify all is working. If not please escalate the issue as soon as possible
* Pull the remote master and proceed with other features/bugfixes

  
