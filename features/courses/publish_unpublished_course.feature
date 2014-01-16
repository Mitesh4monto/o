Feature: delete created course
  In order to manage my created courses
  As a user
  I want to be able to publish a course in my created courses so that all can see it

    Background:
      Given I am logged in

    Scenario: User publishes a course
      Given I have a created published course
		And I am on the my courses page
      	When I click created course link
		And I click link "Edit"
 	  	And I fill in "Name" with "updated course name"
 	  	And I check "Published"
		And I press "Update Course"
      	Then I should see a successful course update message
		When I go to the courses page
		Then page should have course named "updated course name"
      
	    Scenario: User unpublishes a course
	      Given I have a created published course
			And I am on the my courses page
	      	When I click created course link
			And I click link "Edit"
	 	  	And I fill in "Name" with "updated course name"
	 	  	And I uncheck "Published"
			And I press "Update Course"
	      	Then I should see a successful course update message
			When I go to the courses page
			Then page should not have course named "updated course name"

