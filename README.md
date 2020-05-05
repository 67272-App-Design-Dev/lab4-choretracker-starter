# Part 1

1. Use git to clone the base project set up [on github](https://github.com/495-Labs-Projects/ChoreTracker) and **review the contents before proceeding**. Look at the ERD that is in the `doc/` directory. Basically, you have a project that has been scaffolded in accordance with the ERD, but there is essentially no model code apart from what comes with ApplicationRecord. In the first part we will be using Test Driven Development (TDD) to build out these models and verify that it is working. In the second part of the lab we will do some clean up of the views to take advantage of some of the model code we've written

    *   Run the bundle command to install the new gems used in this project:

        ```ruby
        bundle install
        ```

    *   Install the `validates_timeliness` support files using the rails generator:

        ```ruby
        rails generate validates_timeliness:install
        ```

    Commit these changes to git.

    *   Run `git branch` to see that you are on the master branch. Run the `rails db:migrate` command to generate the development database. Then run `rails db:test:prepare` to generate the test database. Once this is done, switch to a different branch called `models`.

2.  Now we are going to test the Child model by writing some unit tests. Open the `test/test_helper.rb` file and set the use of transactional fixtures to false by commenting out the line `fixtures :all`. At the very top of file, add in the support for [simple_cov](https://github.com/colszowka/simplecov) (a gem which will give us basic test coverage statistics) by adding the following lines:

    ```ruby
      require 'simplecov'
      SimpleCov.start 'rails'
    ```

    If you have forgotten to do so by this point, then **make sure you are committing your work to git**. Hopefully it is becoming second nature now. It is a great idea to be regularly saving your code to git or some other form of source code control and to take advantage of branching when appropriate. (Your discretion today when to do these things...)

3.  Getting back to the code, within the `test/` directory, there is a file called `factories.rb`. In that file, we need to complete the Child factory. Set the first name of the child by default to 'Alex' and the last name to 'Heimann' by default. Look at the other factories provided to understand the syntax. For a list of fields on the Child model, look at the `db/schema.rb` file (ignore created_at and update_at fields). **Have a TA verify that the factories are correct before proceeding.**

4.  Now we are going to practice test driven development by writing out our tests in these first few steps, then later writing our model code to pass these tests. We are ready to create unit tests for the Child model. Open the `child_test.rb` file within the `test/models/` directory. In the first section, we will add some shoulda matchers, beginning with relationship matchers:

     ```ruby
       should have_many(:chores)
       should have_many(:tasks).through(:chores)
     ```

    We will write more tests in just a moment, but for now let's try running these tests for the Child model in the command line. Rails makes it easy to do this, simply use the command `rails test test/models/child_test.rb`. This will perform all our unit tests contained within just the `child_test.rb` file. Of course, we fail these tests, since we haven't written relationship code for the Child model yet. In this way, you can test a single model on its own, or you can run your full unit test suite by executing `rails test test/models` on the command line, which will just execute all tests contained in the `test/models` directory.

5. Back to writing tests for Child, we next add in validation matching:

      ```ruby
        should validate_presence_of(:first_name)
        should validate_presence_of(:last_name)
      ```

    Again test these by running `rails test test/models/child_test.rb` on the command line and watch them fail.

6.  Before we continue we should set up contexts for more complex unit tests. Essentially a context is a controlled environment where the same database setup is replicated before each test within the context to test the same data on various scenarios. For example, we can create a context where there are 3 children in the system, 2 of which are active. We then can use knowledge about these children within the context to set up testing scenarios.

    To save you time and typing, we've provided in the `contexts.rb` file a method called `create_children` which adds a diverse set of objects to the test database and `destroy_children` which wipes them out. If you call these methods in the the setup and teardown method in `ChildTest` we can create a clean testing environment for each test so we know what the tests should return if the methods being tested are working properly. To verify it is working add this code to the bottom of your `child_test.rb` file:

     ```ruby

      context "Creating a child context" do
        setup do
          create_children
        end

        teardown do
          destroy_children
        end

        should "have name methods that list first_ and last_names combined" do
          assert_equal "Alex Heimann", @alex.name
          assert_equal "Mark Heimann", @mark.name
          assert_equal "Rachel Heimann", @rachel.name
        end

        should "have a scope to alphabetize children" do
          assert_equal ["Alex", "Mark", "Rachel"], Child.alphabetical.map{|c| c.first_name}
        end

        should "have a scope to select only active children" do
          assert_equal ["Alex", "Mark"], Child.active.alphabetical.map{|c| c.first_name}
        end
      end

    ```

    Review this code so you understand how it works and ask a TA for help if you are unclear about any aspect of it.

7.  Looking at the first test, we need to test the `alphabetize` scope which essentially alphabetizes the children by name. We know what the result should be for these 3 children and can compare that with what the method returned. Observe this testing scenario in the following line copied from above:

    ```ruby
      assert_equal ["Alex", "Mark", "Rachel"], Child.alphabetical.map{|c| c.first_name}
    ```

8.  Looking at the second test, we need to test the `active` scope which lists out all of the active children. We know what the result should include the 2 active children, but we don't know in which order they will appear so we call the alphabetical scope once again and make sure that our array includes the names of Alex and Mark in alphabetical order too. Again, observe the following line copied from above:

    ```ruby
     assert_equal ["Alex", "Mark"], Child.active.alphabetical.map{|c| c.first_name}

    ```

    If you run the unit tests at any point in these first few steps you will see lots of failing tests since we don't have any corresponding code in the model. But that's okay, writing thorough tests now will be helpful as we write out our model.

# <span class="mega-icon mega-icon-issue-opened"></span>Stop

Show a TA that you have the basic tests written for the Child model and that you have properly saved the code to git. Make sure the TA initials your sheet.

* * *

# Part 2

  Start by checking on the output of these tests once more with `rails test test/models/child_test.rb`.

  **You should see failures and errors!** Don't panic - we are going to fix them now.

1.  We need relationships to `chores` and `tasks`, so open up the Child model and add the appropriate relationships. Rerun the tests and verify that the test for these relationships pass.

2.  Add `validates_presence_of` validators for `first_name` and `last_name` and rerun your tests. You should have two more passing tests.

    **Commit these changes to your repository**.

3. Create a new method in your `Child` model called `name` that returns "First Last":

    ```ruby
    def name
      # ...
    end

    ```

    Run the tests again and see that another test passes.

4. Add a scope to the `Child` model to alphabetize by last_name, first_name:

    ```ruby
    scope :alphabetical, -> { order(...) }

    ```

    Run the tests again and see that another test passes. In case you don't believe the test is actually passing, try removing an element from the intended array specified in the child tests file and watch the test fail until you add that item back in.

5. Add a scope to the `Child` model to only return active children:

    ```ruby
    scope :active, -> { where(...) }

    ```

    Re-run the tests and you should and they should all pass + 1 error (about missing the Chore model).

    Commit these changes to git.

6. Now that you have a complete set of passing tests for the Child model, switch back to master and merge the `models` branch into master.

# <span class="mega-icon mega-icon-issue-opened"></span>Stop

  Show a TA that you have the Rails app set up, the first set of unit tests passing, and have branched as instructed, properly saved the code to git, and merged back to master. Make sure the TA initials your sheet.

* * *

# Part 3

1.  Switch back to the `models` branch.

2.  Below is the entire testing file you need to copy into `task_test.rb` to use to test the `Task` model. Following a similar process as above, fix/extend the `Task` model until all these tests pass. Note how we test the input value for the points field - you will need this in the coming phase. Also notice that we need to map the task id to the name so that our scope tests can easily match an array.

    ```ruby
    require 'test_helper'

    class TaskTest < ActiveSupport::TestCase
      should have_many(:chores)
      should have_many(:children).through(:chores)
      should validate_presence_of(:name)
      should validate_numericality_of(:points)
      should allow_value(1).for(:points)
      should allow_value(10).for(:points)
      should allow_value(100).for(:points)
      should_not allow_value("bad").for(:points)
      should_not allow_value(-2).for(:points)
      should_not allow_value(3.14159).for(:points)

      context "Creating five tasks" do
        setup do
          create_tasks
        end

        teardown do
          destroy_tasks
        end

        should "have a scope to alphabetize tasks" do
          assert_equal ["Mow grass", "Shovel driveway", "Stack wood", "Sweep floor", "Wash dishes"], Task.alphabetical.map{|t| t.name}
        end

        should "have a scope to select only active tasks" do
          assert_equal ["Mow grass", "Shovel driveway", "Sweep floor", "Wash dishes"], Task.active.alphabetical.map{|t| t.name}
        end
      end
    end

    ```

    **Once they all pass and are committed, switch back and merge with `master`.**

3.  Switch back to the `models` branch. This time before doing any testing of `Chore` we are going use the Rails Console for testing. Start by accessing it in the command line with the command:

    ```
      rails console
    ```

4.  Type the following command to use FactoryBot:

    ```
      require 'factory_girl_rails'
    ```

5.  We need to add the context to the development database. To do that, we first must require the context file:

    ```
      require './test/contexts'
    ```

6.  Next we need to include this module so we can call on the functions that build and destroy our testing objects. To do that, use the command:

    ```
      include Contexts
    ```

7.  Build part of the testing context by running the following two commands:

    ```
      create_children
      create_tasks
    ```

8.  Type `Child.active` and see that you get back records for Alex and Mark (but not Rachel).

9.  Type `@alex.name` and see that you get 'Alex Heimann'.

10.  Type `b = Child.new` to get an empty child object.

11.  Now type `b.first_name = 'Becca'` and then `b.save!` and see this fails because no last name is specified.

  Add a last name and see the child object does indeed save.

  Rails Console is a great way to test your models informally or to debug issues that are happening on the back end.

  **Note: this is _not_ a substitute for unit testing, but it is a great way to quickly and informally figure out problems with your code and better understand the output of Rails methods.**

12. There are some great resources online regarding the Rails Console - below are two articles that you might want to check out later:

  * [Secrets of the rails console ninjas](http://slash7.com/articles/2006/12/21/secrets-of-the-rails-console-ninjas)
  * [Real console helpers](http://errtheblog.com/posts/41-real-console-helpers)

13.  Below is the entire testing file you need to copy into `chore_test.rb`. It is the most complex of the three models, so read through the file and once you understand it, run the tests to see the failures and then start writing methods to correct these errors. Note how we are using the timeliness gem to test the input value for the due_on field - you will also need this in the coming phase.

  * The chore test file:
    ```ruby
    require 'test_helper'

    class ChoreTest < ActiveSupport::TestCase
      should belong_to(:child)
      should belong_to(:task)
      should allow_value(1.day.from_now.to_date).for(:due_on)
      should allow_value(1.day.ago.to_date).for(:due_on)
      should allow_value(Date.today).for(:due_on)
      should_not allow_value("bad").for(:due_on)
      should_not allow_value(3.14159).for(:due_on)

      context "Creating a set of chores" do
        setup do
          create_children
          create_tasks
          create_chores
        end

        teardown do
          destroy_children
          destroy_tasks
          destroy_chores
        end

        should "has a scope to order alphabetically by task name" do
          assert_equal ["Shovel driveway","Sweep floor","Sweep floor","Sweep floor", "Wash dishes","Wash dishes","Wash dishes"], Chore.by_task.map{|c| c.task.name}
        end

        should "has a scope to order chronologically by due_on date and suborder alphabetically by task name" do
          assert_equal ["Shovel driveway","Sweep floor","Wash dishes","Sweep floor","Wash dishes","Sweep floor","Wash dishes"], Chore.chronological.map{|c| c.task.name}
        end

        should "has a scope for pending chores" do
          assert_equal 4, Chore.pending.size
        end

        should "has a scope for done chores" do
          assert_equal 3, Chore.done.size
        end

        should "has a scope for upcoming chores" do
          assert_equal 6, Chore.upcoming.size
        end

        should "has a scope for past chores" do
          assert_equal 1, Chore.past.size
        end

        should "display the status of shoveling [@ac3] as 'Completed'" do
          assert_equal "Completed", @ac3.status
        end

        should "display the status of sweeping [@mc1] as 'Pending'" do
          assert_equal "Pending", @mc1.status
        end
      end
    end

    ```
    Hint: The scope :by_task is different than other scopes you've seen and you will need to use a join. If you're stuck on this, ask a TA for help.

    **Once these tests all pass, merge the code back into the `master` branch.**


14.  Now go back to the Child model and create a new method called `points_earned` that returns the points a child has earned for completed chores. Try this on your own first if you have time. If not or you are stuck, we will give you the method straight-up. (`inject` was covered in RubyMonk, but people still may not get it.) Make sure you understand the code below first before including it and ask a TA if you are unsure. Once you are comfortable with it, re-run the tests and see another one pass.

```ruby
def points_earned
  self.chores.done.inject(0){|sum,chore| sum += chore.task.points}
end 
```

  Run all three model tests by executing `rails test test/models` on the command line and make sure everything is passing. 

15.  Before we go, let's check the testing coverage. To do this, go to the coverage directory of the project, open the file `index.html` in your browser, click on the models tab and view the coverage for your models. Standard procedure is to ensure 100% test coverage for all of our lines of code, but notice one of the models is not at 100%! This is because we added the `points_earned` method without any test cases (which is not good). Add in some test cases to ensure that this model is back up to 100% test coverage.

  Then merge back to master and get the lab checked-off. 

# <span class="mega-icon mega-icon-issue-opened"></span>Stop

  Show a TA that you have the unit tests for all three models passing, and have properly saved the code to git and merged back to master. Make sure the TA initials your sheet.

* * *


# Part 4

  **This last section can be skipped for now if you are running out of time in lab, but a good idea to go back to later in prep for phase 3.**

1.  Now that we have a working Chore model, go to rails console and run the `create_chores` method to populate the system with some chores. [**Note**: If you didn't have rails console running on a separate tab and are restarting it, you will need to (a) run `Child.destroy_all` and `Task.destroy_all` to clear the old records, then (b) require `factory_girl_rails` and the context again (see above), and then (c) run all three create_ methods (children, tasks, chores) to populate the database.]

2.  We can now test the basic application in the browser by starting up the server with `rails server` and going to http://localhost:3000 in the browser. If there are problems, see a TA for help. **Vagrant users**: Rails server breaks on older labs using vagrant. Go to your Gemfile and remove `gem 'thin'`. Then start rails server with `rails server -b localhost`.

3.  Let's do a little clean-up of the views, starting with our default page. First, go to the `chores_controller.rb` and set `@chores = Chore.chronological.by_task.all` in the index action.

4.  Now go to the 'chores#index' view and replace the two ids with names, format the date with `strftime('%b %d')` and replace completed with status. View the results in the browser and see that the page is a little more readable, although certainly additional edits can also be made if you desire (and have the time).

5.  Go into the `children_controller.rb` and list these children alphabetically. In the index view, replace the 'active' field with `<%= child.active ? "Yes" : "No" %>` so we get something a little less like geekspeak. Additional edits are up to you as time allows. Make similar changes to the index view of tasks.

6.  Click on the `Chores` link and then click on the "New chore" link at the bottom of the page. Looking at the form we see it completely unacceptable. Most importantly, we need to replace the number boxes for ids with select menus listing active children or tasks. In the `_form.html.erb` partial for chores, replace the `number_field` for `child_id` with the following:

    ```erb
      <%= f.collection_select :child_id, Child.alphabetical.active.all, :id, :name, :prompt => "Select child..." %>
    ```

    Do something similar for tasks and verify in the browser that you have menus showing the correct data. After that, add `:order => [:month, :day, :year]` to the due_on field so the order is more natural for the user. Verify that you can add a chore to the system. Looking at the show page, we see we need to correct it by (1) getting rid of the redundant notice at the top, (2) replacing ids with names, (3) make the date more user-friendly as we did in step 10, and replace the completed method with the status method. Do that and reload the page to see the changes.

# <span class="mega-icon mega-icon-issue-opened"></span>Stop

  Show a TA that you have the Rails app set up, it is populated with test data that you got in part from the console exercise and that the views look as they should. Make sure the TA initials your sheet.

* * *

# On Your Own

  I know you are working on Phase 2 feverishly, but this week also take a little time to go to [RubyMonk's free Ruby Primer](http://rubymonk.com/learning/books/1) and complete the following brief exercises:

*   Lambdas in Ruby
*   Blocks in Ruby

These exercises teach powerful techniques that will help you on future phases and exams, and are applicable to practically all modern programming languages (not just Ruby).

* * *
## List of Shoulda Matchers

**Shoulda::ActiveRecord::Matchers**
[items in square brackets are options; almost all matchers have option .with_message('msg')]

*   should belong_to(:model)[.class_name("ModelClassName")][.dependent(:destroy)]
*   should have_one(:model)[.class_name("ModelClassName")][.dependent(:destroy)]
*   should have_many(:models)[.class_name("ModelClassName")][.dependent(:destroy)]
*   should have_many(:models).through(:reference)[.class_name("ModelClassName")][.dependent(:destroy)]
*   should allow_value("var").for(:field)[.on(:context)]
*   should_not allow_value("var").for(:field)[.on(:context)]
*   should allow_mass_assignment_of(:field)[.as(:role)]
*   should_not allow_mass_assignment_of(:field)[.as(:role)]
*   should validate_presence_of(:field)
*   should validate_absence_of(:name)
*   should validate_numericality_of(:field)[.only_integer][.is_greater_than][.is_less_than]
*   should validate_uniqueness_of(:field)[.case_insensitive]
*   should validate_acceptance_of(:field)
*   should ensure_length_of(:field)[is_at_least(num)][.is_at_most(num)][.is_equal_to(num)]
*   should ensure_inclusion_of(:field)[.in_range(n..m)][.in_array(ary)]
*   should ensure_exclusion_of(:field)[.in_range(n..m)][.in_array(ary)]
*   should have_db_column
*   should_not have_db_column
*   should have_db_index
*   should accept_nested_attributes_for(:model)[.allow_destroy(true/false)][.update_only(true/false)][.limit(num)]
*   should have_secure_password
