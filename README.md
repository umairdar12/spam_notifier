# README

## Ruby version
This app is built using Ruby version 3.1.0

## Rails version
This app uses Rails version 7.0.4

## Database
This app uses PostgreSQL version 14.6 as the database.

## Getting Started
To get started with this app, follow the steps below:

1. Clone the repository using `git clone https://github.com/username/repo-name.git`
2. Run `bundle install` to install all the required dependencies.
3. Create the database using `rails db:create`
4. Run database migrations using `rails db:migrate`
5. Run the Rails server using `rails s`
6. Visit the app in your web browser at `http://localhost:3000`
7. You need an API testing tool e.g PostMan to test this.
8. Create an app for your slack.
9. Allow webhooks for the app.
10. Add SLACK_WEBHOOK_URL and SLACK_WEBHOOK_CHANNEL in application.yml.
11. Hit the endpoint http://localhost:3000/notify_spam with payload and you will receive notification in that channel if payload is a spam.


## Testing
This app uses RSpec for testing. To run the tests, use the command `rspec`.

## Deployment
This app can be deployed using a cloud-based platform like Heroku or AWS. 

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/username/repo-name. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the Contributor Covenant code of conduct.

## License
The app is available as open source under the terms of the MIT License. See [LICENSE](LICENSE) for more information.