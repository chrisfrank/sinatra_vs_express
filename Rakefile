require "bundler/setup"
task :setup do
  Bundler.require(:default)
  puts "setting up a database with 10,000 posts ..."
  system "touch db.sqlite3"
  DB = Sequel.connect "sqlite://db.sqlite"
  Sequel.extension :migration
  Sequel::Migrator.apply(DB, '.')
  1000.times do |i|
    DB[:posts].insert({name: "Post Number #{i+1}"})
  end
  puts "... done"
end
