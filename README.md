Sinatra vs Express Benchmarks
=============================

I love writing UI logic in JavaSript, but I still prefer Ruby on the server. It's more elegant, I think.

But is Ruby slower? If so, how much slower? I wrote this benchmark to find out.

It turns out that, for the kind of work I do, at least, Sinatra is a little bit *faster* than Express.

## The Test

The Sinatra app in `main.rb` talks to a SQLite database, and returns some records as JSON.

The Express app in `main.js` does exactly the same thing, but in JavaScript.

Running `ruby benchmark.rb` starts both apps simultaneously, on different ports, then uses Apache Bench to bombard them with requests.

Each app gets hit three times, returning 10, 100, and then 1,000 JSON records sequentially.

## Results

I ran the benchmark three times on my local iMac. Sinatra was a little faster every time.

I wondered if running the test locally was messing up the results, so I also ran a version of the test where `ab` ran from an EC2 Micro Instance, and each app (`main.js` and `main.rb`) ran on a separate Heroku 1x Dyno. The results were the same: Sinatra was a little faster every time.


## Running the Benchmarks Yourself
You need node.js, npm, ruby, and bundler installed on your system.

1. Clone the repo. `git clone https://github.com/chrisfrank/sinatra-vs-express.git`
2. Run `bundle install` to install the ruby gems you'll need.
3. Run `npm install` to install npm packages you'll need.
4. Run `rake setup` to create a database and seed it with test records.
5. Run `ruby benchmark.rb` to run the tests.

