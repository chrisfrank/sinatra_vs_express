Sinatra vs Express Benchmarks
=============================

I love writing UI logic in JavaSript, but I still prefer Ruby on the server. It's more elegant, I think.

But is Ruby slower? If so, how much slower? I wrote this benchmark to find out.

It turns out that, for the kind of work I do, at least, Sinatra is a little bit *faster* than Express.

## The Test

The Sinatra app in `main.rb` talks to a SQLite database, and returns some records as JSON.

The Express app in `main.js` does exactly the same thing, but in JavaScript.

Running `ruby benchmark.rb` starts both apps simultaneously, on different ports, then uses Apache Bench to bombard them with requests.

Each app gets hit three times, returning 10, 100, and then 1,000 JSON records sequentially. I have `ab` set to run 2,000 requests, at a concurrency level of 50.

## Results

I ran the benchmark three times on my quad-core iMac i5. Sinatra was a little faster every time.

### Sinatra vs Express, Requests per Second

|             | 10 Posts | 100 Posts | 1000 Posts | 
|-------------|----------|-----------|------------| 
| Sinatra AVG | 1281     | 654       | 109        | 
| Express AVG | 1179     | 578       | 92         | 
| Sinatra 1   | 1282     | 656       | 109        | 
| Express 1   | 1188     | 562       | 93         | 
| Sinatra 2   | 1281     | 655       | 110        | 
| Express 2   | 1173     | 606       | 91         | 
| Sinatra 3   | 1279     | 651       | 109        | 
| Express 3   | 1176     | 566       | 93         | 

### Sinatra vs Express, Mean Response Time

|             | 10 Posts | 100 Posts | 1000 Posts | 
|-------------|----------|-----------|------------| 
| Sinatra AVG | 39ms     | 76ms      | 458ms      | 
| Express AVG | 42ms     | 86ms      | 541ms      | 
| Sinatra 1   | 39ms     | 76ms      | 460ms      | 
| Express 1   | 42ms     | 89ms      | 539ms      | 
| Sinatra 2   | 39ms     | 76ms      | 453ms      | 
| Express 2   | 42ms     | 82ms      | 547ms      | 
| Sinatra 3   | 39ms     | 77ms      | 460ms      | 
| Express 3   | 42ms     | 88ms      | 536ms      | 


I wondered if running the test locally was messing up the results, so I also ran a variation of the test where `ab` ran from an EC2 Micro instance, and each app (`main.js` and `main.rb`) ran on a separate Heroku 1x Dyno. The results were the same: Sinatra was a little faster every time.

## Sinatra vs Express, Req/Sec, Independent Heroku Dynos

|         | 10  Posts | 1000 Posts | 1000 Posts | 
|---------|-----------|------------|------------| 
| Sin AVG | 612       | 284        | 57         | 
| Ex AVG  | 435       | 206        | 32         | 
| Sin 1   | 512       | 175        | 53         | 
| Ex 1    | 346       | 200        | 32         | 
| Sin 2   | 660       | 323        | 57         | 
| Ex 2    | 417       | 194        | 34         | 
| Sin 3   | 664       | 355        | 62         | 
| Ex 3    | 541       | 223        | 30         | 


## Running the Benchmarks Yourself

I'd love to see whether other people get similar results, especially if you tweak the `ab` concurrency level in `benchmark.rb`.

The tests are simple to run. You'll need [node.js](https://nodejs.org), [npm](https://www.npmjs.com), [ruby](https://www.ruby-lang.org), and [bundler](http://bundler.io) installed on your system. Once you have those:

1. Clone the repo. `git clone https://github.com/chrisfrank/sinatra-vs-express.git`
2. Run `bundle install` to install the ruby gems you'll need.
3. Run `npm install` to install npm packages you'll need.
4. Run `rake setup` to create a database and seed it with test records.
5. Run `ruby benchmark.rb` to run the tests.

Note that the Sinatra app is running [Puma](http://puma.io) as its server, set to the default single-worker, multi-threaded mode. I unscientifically tried [Thin](https://github.com/macournoyer/thin) too. Results were similar: it's a little faster than Express.

Adding additional workers to Puma increased throughput by a lot, but I wanted to keep the official test simple and fair. If you're comfortable running Express in cluster mode with Throng or whatever, I'd love to see a multi-worker benchmark.
