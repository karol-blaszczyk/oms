App reflects provided requirements and was scaffolded quickly.

Initial monolith app from iteration sprints can start.
###### todo :
  * cleanup (ex. controllers can be smaller)
  * namespacing  
  * api versioning
  * auth
  * etc.

#### System characteristics should be defined. IMHO most important ones are:  

  * Agility ( how fast we can react to fast dynamic business requirements )
  * Simplicity ( implementation needs to be easy to understand, simple to manipulate )
  * Maintainability ( easy to test, maintain )
  * Security ( not common in most architectures , money is involved )
  * Deployability (change can land on production quickly)

API could be written in smaller framework (ex: Sinatra), however, new rails are versatile which makes
agility great,

Performance is not the key requirement (we not looking for a nano second responses).

For state machine: aasm gem which is well maintained, and battle tested

Database is thing to debate

TDD, BDD. Specs should cover core functionalities on high level along with all method specs,

Some base principals to code:
  * Test coverage threshold : 97% (ex: Rspec + Cucumber)
  * Method documentation : 100% ( ex: YARD + SWAGGER )
  * Keep linters up to date ( ex: rubocop )
  * Avoid monkey-patching
