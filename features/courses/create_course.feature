Feature: Create a course
  In order to author a course
  As a user
  I want to be able to create a course

    Background:
      Given I am logged in

    Scenario: User creates course with all fields filled out
      Given I am on the newcourse page
      # Given I click link create a course
	  And I fill in "course_name" with "course name"
	  And I fill in "Overview" with "my overview"
	  And I fill in "About the author" with "ab auth non"	
	  And I fill in "course_description" with "my course descri"
	  When I press "Create Course"
      Then I should see a successful creation message
      And page should have course named "course name"
      
    Scenario: User creates course with no field filled out
    # Given I click link create a course
    Given I am on the newcourse page
	  When I press "Create Course"
      Then I should see an error message
	  And I should see on page "Name can't be blank"
