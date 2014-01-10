Feature: add activity to self plan
  In order to have another activity in plan added by self
  As a user
  I want to be able to add an activity to my plan

    Background:
      Given I am logged in

    Scenario: User adds activity with all fields filled out
      Given I am on the addactivity page
	  And I fill in "Title" with "acttit"
	  And I fill in "Timing expression" with "yaba"
	  And I fill in "activity_description" with "descri"
	  When I press "Create Activity"
      Then I should see a successful addition message
      And page should have activity titled "acttit"
	  When I click link "acttit"
	  Then I should see on page "descri"
      
    Scenario: User adds activity with no field filled out
      Given I am on the addactivity page
	  And I fill in "Timing expression" with "yaba"
	  And I fill in "activity_description" with "descri"
	  When I press "Create Activity"
	  Then I should see on page "can't be blank"
	
    Scenario: User cancels add activity
      Given I am on the addactivity page
	  And I fill in "Timing expression" with "yaba"
	  And I fill in "activity_description" with "descri"
	  When I click link "cancel"
	  Then I should be on my plan page
