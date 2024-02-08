First you need to pull down any code updates.

Run `git pull --rebase` from the command line inside the project directory. Hopefully there are no any errors. If there are, message Lew.

You can see in the file `db/schema.rb:48` around line 48 that the table `team_score_sheets` does not yet have a field for this data.

At the command line run:

`rail g migration AddScoreScoreHarmonyToTeamScoreSheets`

(When creating a database migration it is best to add a very descriptive name.)

This will create a file with that name in `db/migrate` that will be prefixed by a timestamp. This is how Rails updates the structure of the database.

You will need to update this file to add a column `score_harmony`.
See `db/migrate/20240112162219_add_score_trap_to_match_actions.rb:3` for an example of how to do this.

Note the ` :default => 0` at the end. This is important to tell the database to make any existing rows in the database equal to 0 and all future records to have a default value of 0.

Next run

`rake db:migrate`

If there are no errors then you are good to go. You can go back to `db/schema.rb` and see that the column has been added.

Next you should update the script that adds fake data to the project.

Open `db/seeds.rb:51` and copy one of the other lines that looks like `score_trap: Random.rand(30),`. Replace the `score_trap` with `score_harmony`.

Next, run `rake db:seed`.

If there are no errors, then you will have added some records with random amounts of  score_harmony values.

Awesome!

Next lets add the buttons for updating the scores.

Open `app/views/team_score_sheets/_teleop_section.html.erb:8`

Copy the code for `score_speaker` and paste it below. That code looks like

```ruby
<%= render 'score_buttons',
           score_field: :score_speaker,
           team_score_sheet: @team_score_sheet,
           score_url: score_speaker_competition_match_team_score_sheet_path(@match.competition, @match.id, @team_score_sheet.id, increment: 1),
           undo_url: score_speaker_competition_match_team_score_sheet_path(@match.competition, @match.id, @team_score_sheet.id, increment: -1)
%>
```

In your copied code, everywhere you see `score_speaker` replace it with `score_harmony`. Make sure not to replace anything in the existing code.

You can now look at the app in the browser, navigate to a team score sheet by clicking on a team number in the matches list, and after you click `End Auto` you should see a new set of buttons. You might get an error at this point though. I'm not sure. No worries. The next steps should fix it.

You can see what is being rendered by opening `app/views/team_score_sheets/_score_buttons.html.erb:5`. On line 5 you'll see some odd code `t(score_field)`. Rails uses internationalization, or i18n for short, to figure out what text to display. In this case, it is the name on the button.

Open `config/locales/en.yml:36` and add a line `score_harmony: HARMONY`. Make sure the indentation level is the same as the other line. This is a YAML file and like Python, indentation matters.

Go back to the browser, refresh, and if the buttons are displaying you should see the new text appear. If so, click the button.

You should get an errors screen that says something like

`No route matches team_score_sheets/something/something....`.

We have to tell Rails where to send the AJAX request triggered by the button click.

Open `config/routes.rb:13` and add a line after

`post :score_trap, on: :member`

`post :score_harmony, on: :member`

This tells rails to route the AJAX request to the `team_score_sheets_controller`. Magic!

Read more about routing [here in the Rails guides](https://guides.rubyonrails.org/routing.html)

Now we have to tell that controller what to do with the request.

Open `app/controllers/team_score_sheets_controller.rb:28` and copy the code

```ruby
def score_trap
    score(:score_trap)
end
```

Make the copied code look like:
f
```ruby
def score_harmony
    score(:score_harmony)
end
```

Now if you go back to the browser and hit the `HARMONY` button or the `UNDO` button next to it you should see the score update!

You are done! Woo!

Let's ship your code.

We are going to do this old-school from the command line. We are also not going to worry about any branching and pull request business.

Go to the Ubuntu command line.

Inside the Scouting2024 directory...

Run
```
git add .
git commit -m 'Adds Score Harmony to the team score sheet'
git pull --rebase
```

If those 3 commands run with no errors, then push up you code with

```
git push origin main
```

If that works, then you are ready to finish this story. At the top of this, push the blue "Finish" button.

Discord me to let me know your story is ready to be pushed to the demo site and we will see if it works in the real world.

Great job!

