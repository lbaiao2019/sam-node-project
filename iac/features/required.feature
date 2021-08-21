Feature: test
  In order to make sure all required attributes are provided:

Scenario Outline: Must contain attributes
  Given I have aws_iam_policy defined
  Then it must contain <attributes>

  Examples:
    | attributes        |
    | name              |
    | path              |
    | description       |
    | policy            |

Scenario Outline: Must contain attributes
  Given I have aws_s3_bucket defined
  Then it must contain <attributes>

  Examples:
    | attributes         |
    | bucket             |
    | tags               |


Scenario Outline: Must contain attributes
  Given I have aws_lambda_function defined
  Then it must contain <attributes>

  Examples:
    | attributes          |
    | function_name       |
    | runtime             |
    | publish             |
    | role                |
    | tags                |

  Scenario Outline: Ensure that specific tags are defined
    Given I have resource that supports tags defined
    When it has tags
    Then it must contain tags
    Then it must contain <tags>
    And its value must match the "<value>" regex

    Examples:
      | tags         | value              |
      | owner        | .+                 |
      | service_name | .+                 |
      | managed_by   | .+                 |
      | environment  | .+                 |
      | versioning   | .+                 |