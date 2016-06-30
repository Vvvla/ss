Feature: Test scenarios for Svitla

  Background:
    Given I navigate to 'Google' start page
    And I fill search field with following data: 'aikido'

  Scenario: Capturing screenshot from wikipedia

    When I open wikipedia page for search word
    Then I should see wikipedia page
    And I should see that page has content: 'modern Japanese martial art developed by Morihei Ueshiba'
    When I make a screenshot with name 'Wikipedia Match'


  Scenario: Capturing screenshot from link after wikipedia

    When I open link after wikipedia and remember it description
    Then I should see page with search word and stored description
    When I make a screenshot with name 'Next Link Match'
