# Rush Hour

Rush Hour is an application that mimics the functionality of google analytics on
the back end. It assumes that the client already has the JavaScript necessary
to send JSON to the server. The JSON object contains request information about
the user visiting the clients website. With this data, we can then calculate such
things as the most frequently visited path, request method and other HTTP related
information.

## Getting Started

To get started, you want to first clone done the repo:

```bash
  $ git clone https://github.com/julsfelic/rush-hour-skeleton
```

Then go ahead and cd into the project and setup the database:

```$bash
  $ cd rush-hour-skeleton
  $ bundle
  $ rake db:create db:migrate
```

Then run `$ rails s` and you'll have the app up and running!

### Prerequisities

In order to run the app you will need both Ruby & Rails installed on your local
machine. Here are some links to set that up:

#### Ruby & Rails
* [Install Rails](http://installrails.com/)

## Running the tests

To run the test suite, user the ```$ rake test``` command.

## Built With

* Sinatra - [Sinatra Website](http://www.sinatrarb.com/)
* ActiveRecord - [ActiveRecord Website](https://github.com/rails/rails/tree/master/activerecord)
* PostgreSQL - [PostgreSQL Website](http://www.postgresql.org/)

## Contributing

Feel free to submit pull request and I will get back to them in a timely matter.

## Authors

* **Julian Feliciano** - [Github](https://github.com/julsfelic)
* **Scott Firestone** - [Github](https://github.com/scottfirestone)
* **Nate Venn** - [Github](https://github.com/natevenn)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
