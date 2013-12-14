Feature: Manage Strategy
  In order to manage my strategy
  As a user
  I want to create and manage activities
  
  Scenario: Activities List
    Given I have Activities titled work out, eat more
    When I go to my strategy
    Then I should see "work out"
    And I should see "eat more"