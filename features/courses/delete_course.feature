Feature: delete created course
  In order to manage my created courses
  As a user
  I want to be able to delete a course from my created courses

    Background:
      Given I am logged in

    Scenario: User deletes a course
      Given I have a created course
		And I am on the my courses page
      	When I click link "Delete"
      	Then I should see a successful course deletion message
      
