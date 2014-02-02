Feature: contact us
  In order to communicate w/ miaou 
  As a user
  I want to be able to send an email

    Scenario: logged in user send message
      Given I am logged in 
	  And I am on the contact us page
	  And I fill in "Message" with "my contact body"
	  When I press "Send"
      Then I should see a successful send message

      
    Scenario: unlogged in user send message
      Given I am on the contact us page
	  And I fill in "Name" with "my name"
	  And I fill in "Email" with "fsdf@fsdf.com"
	  And I fill in "Message" with "my contact body"
	  When I press "Send"
      Then I should see a successful send message
