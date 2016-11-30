Sinatra vs Express Benchmarks
=============================

I love writing UI logic in JavaSript, but I still prefer Ruby on the server. It's more elegant, I think.

But is it slower? If so, how much slower? I wrote this benchmark to find out.


## Setup
You need node.js, npm, ruby, and bundler installed on your system.

1. Clone the repo. `git clone https://github.com/chrisfrank/sinatra-vs-express.git`
2. Run `bundle install` to install ruby files
3. Run `npm install` (to install npm packages)
4. Run `rake setup` to create a database and seed it with test records.
5. Run `ruby benchmark.rb` to run the tests.

