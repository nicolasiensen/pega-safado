Feature: view the most suspicious company of each deputy
  In order to better investigate the deputies
  As a visitor
  I want to view the most suspicious company of each deputy

  Scenario: there is one deputy who held three refunds of different companies last month
    Given there is a deputy
    And this deputy held a refund of 1200 for "Amoreto" last month
    And this deputy held a refund of 800 for "Petroil" last month
    And this deputy held a refund of 400 for "Rede Auto" last month
    When I am in "the homepage"
    Then I should see this deputy
    And the most suspicious company of this deputy should be "Amoreto"
