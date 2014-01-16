Feature: delete created course
  In order to manage my created courses
  As a user
  I want to be able to edit a course in my created courses

    Background:
      Given I am logged in

    Scenario: User edits a course
      Given I have a created unpublished course
		And I am on the my courses page
      	When I click created course link
		And I click link "Edit"
 	  	And I fill in "Name" with "updated course name"
		And I press "Update Course"
      	Then I should see a successful course update message
		And page should have course named "updated course name"
      
