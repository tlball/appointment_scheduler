# README

## Appointment Scheduler
This app provides a basic API backend scheduling appointments.

### Features
* offers coverage 24/7/365, including weekends and holidays
* unlimited practitioners (in other words, any number of users can schedule
  appointments for the same time)
* all appointments are exactly 30 minutes (start and end on the hour or the half
hour)
* users can only have 1 appointment on a calendar date

### API Documentation
#### Creating an appointment
To create a new appointment, there is a `POST` endpoint that takes a date/time
and user ID (both required). Creates an appointment beginning at that time for
that user or returns an appropriate error if the appointment cannot be made
(the user already has an appointment that day).

NOTE: Requests will fail if an invalid User ID is passed. The Development database is seeded with 8 Users, using IDs 1-8.

```
POST /users/:id/appointments
```

##### Parameters
| Name | Type | Requirement| Description |
|------|------|------------|-------------|
| `start_at` | `datetime` | Required | This is the start time for the new appointment. |
| `user_id` | `integer` | Required | The User ID for the patient that is attending the appointment. |

##### Exceptions
###### Invalid dates
If an invalid date is passed, the app will return a `422 Unprocessable Entity` error.

###### Invalid User ID
If an unknown User ID is passed, the app will return a `404 Not Found` error.

###### Missing parameter
If any required parameters are not sent in the request, the app will return a
`400 Bad Request` error along with an appropriate error message.

#### Viewing an appointment
To view a patient's appointment, use the `GET` endpoint that takes a user ID
(required) and returns all appointments for the user.

NOTE: Requests will fail if an invalid User ID is passed. The Development database is seeded with 8 Users, using IDs 1-8.

```
GET /users/:id/appointments
```

##### Parameters

| Name | Type | Requirement| Description |
|------|------|------------|-------------|
| `id` | `integer` | Required | The User ID for the patient to be viewed. |

##### Exceptions
###### Invalid User ID
If an unknown User ID is passed, the app will return a `404 Not Found` error.

###### Missing parameter
If any required parameters are not sent in the request, the app will return a
`400 Bad Request` error along with an appropriate error message.

### Setting up a local environment
To run this application locally, first clone the GitHub repo
```
git clone git@github.com:tlball/appointment_scheduler.git
```

#### Setup Ruby
This app requires Ruby 2.6.3, but can be changed to use anything 2.5 or greater
to prevent the need to install another version of Ruby.

Check your version by running
```
ruby --version
```

If it is not 2.6.3, but is 2.5 or greater replace the version listed in the
`.ruby-version` file with your existing version.

If you have a valid version of Ruby, install or update Ruby with your package manager of choice. Or
install it using RVM following the steps at https://rvm.io/.

#### Installing Gems
Next you need to install the required gem libraries. Navigate to the root directory of the application and run:
```
gem install bundler
bundle
```

#### Create the databases
Last create the development and test databases in SQLite and populate with seed data
```
bundle exec rails db:setup
bundle exec rails db:seed # this will seed the database with 8 users (IDs 1 - 8)
```

### Running tests locally
This application uses the RSpec library for testing. To run all of the tests run
```
bundle exec rspec
```

### Running in the development environment
To run this application locally, start up Rails in your console
```
bundle exec rails server
```

This starts up the application on port 3000. Then using your cURL client of choice, you can make requests
against the above endpoints using that port on localhost.
```
http://localhost:3000
```

#### Additional Information
This app was created and maintained by [Tricia Ball](https://github.com/tlball)
