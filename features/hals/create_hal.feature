Feature: Create a hal
  In order to save an entry
  As a user
  I want to be able to create a hal

    Background:
      Given I am logged in

    Scenario: User creates a hal with all fields filled out
      Given I click link create course
	  And I fill in "Name" with "course name"
	  And I fill in "Overview" with "my overview"
	  And I fill in "About the author" with "ab auth non"	
	  And I fill in "course_description" with "my course descri"
	  When I press "Create Course"
      Then I should see a successful creation message
      And page should have course named "course name"
      
    Scenario: User creates course with no field filled out
    Given I click link create course
	  When I press "Create Course"
      Then I should see an error message
	  And I should see on page "Name can't be blank"
