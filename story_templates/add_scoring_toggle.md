You can see in the file `db/schema.rb:48` around line 48
that the table `team_score_sheets` has a field for this data called `park.

If you look in the database seeding script you will see that this value is
randomly assigned `true` or `false` with the code `park: bools.sample,`.

Next lets add the toggles for updating the park value.

Open `app/views/team_score_sheets/_auto_section.html.erb:5`

Copy the code for `leave`. That code looks like

```html

<div class="cell small-5"></div>
<div class="cell small-6">
    SCORE LEAVE
    <%= form_with(url: leave_competition_match_team_score_sheet_path(@match.competition, @match.id,
    @team_score_sheet.id)) do |form| %>
    <div class="switch large">
        <%= check_box_tag(
        "LEAVE",
        @team_score_sheet.leave?,
        @team_score_sheet.leave?,
        onchange: "this.form.requestSubmit();",
        class: "switch-input",
        name: "leave",
        id: "leave"
        )
        %>
        <label class="switch-paddle" for="leave">
            <span class="show-for-sr">LEAVE</span>
            <span class="switch-active" aria-hidden="true">Yes</span>
            <span class="switch-inactive" aria-hidden="true">No</span>
        </label>
    </div>
    <% end %>
</div>
<div class="cell expanded"></div>
```

Paste that code into the file `app/views/team_score_sheets/_teleop_section.html.erb:23` at the end.

In your copied code, everywhere you see `leave` replace it with `park`.

You can now look at the app in the browser, navigate to a
team score sheet by clicking on a team number in the matches list, and after you click `End Auto`
you should see a new toggle.

Click the toggle.

You should get an errors screen that says something like

`No route matches team_score_sheets/something/something....`.

We have to tell Rails where to send the AJAX request triggered by the toggle.

Open `config/routes.rb:13` and add a line after

`post :leave, on: :member`

`post :park, on: :member,`

This tells rails to route the AJAX request to the `team_score_sheets_controller`. Magic!

Read more about routing [here in the Rails guides](https://guides.rubyonrails.org/routing.html)

Now we have to tell that controller what to do with the request.

Open `app/controllers/team_score_sheets_controller.rb:28` and copy the code

```ruby

def leave
  @team_score_sheet.leave = !@team_score_sheet.leave?
  @team_score_sheet.save
  render_turbo(:leave)
end
```

Paste it below that method after the `end`.

Make the copied code look like:

```ruby

def park
  @team_score_sheet.park = !@team_score_sheet.park?
  @team_score_sheet.save
  render_turbo(:park)
end

```

Next, you need to make sure that `@team_score_sheet` is set to a value.
This is done in the controller as a `before_action` callback. This is a bit of Rails magic that runs a method
automatically
before certain controller methods are called. Go to the top of the controller file and look for this code:

```ruby
before_action :set_team_score_sheet, only: %i[
  show
  edit
  leave
  toggle_auto
]
```

On a new line under `leave` add the name of your new method `park`.

```ruby
before_action :set_team_score_sheet, only: %i[
  show
  edit
  leave
  osntage
  toggle_auto
]
```

Now if you go back to the browser and hit the `SCORE ONSTAGE` toggle you should see the toggle update with no error!
Refresh the page to make sure the value sticks.

You are done! Woo!

Let's ship your code.

We are going to do this old-school from the command line. We are also not going to worry about any branching and pull
request business.

Go to the Ubuntu command line.

Inside the Scouting2024 directory...

Run

```
git add .
git commit -m 'Adds Score Onstage to the team score sheet'
git pull --rebase
```

If those 3 commands run with no errors, then push up you code with

```
git push origin main
```

If that works, then you are ready to finish this story. At the top of this, push the blue "Finish" button.

Discord me to let me know your story is ready to be pushed to the demo site and we will see if it works in the real
world.

Great job!

