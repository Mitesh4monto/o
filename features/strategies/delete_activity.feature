Feature: add activity to self plan
  In order manage my plan
  As a user
  I want to be able to remove an activity from my plan

    Background:
      Given I am logged in

    Scenario: User adds activity with all fields filled out
      Given I am on the my plan page
	  And I have at least one activity in my plan
      When I click image "Delete Activity"
      Then I should see a successful deletion message
      
