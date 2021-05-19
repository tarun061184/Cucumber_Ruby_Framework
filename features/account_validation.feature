Feature: Existing Account Test

  @smoke
  Scenario Outline: Enter all required fields and submit Page 1
    Given I am on Step1 page
    When I fill up the form for "<user>"
    And I Submit the form
    Then I should see account already exists message

    Examples:
    | user  |
    | user1 |
#   | user2 |
