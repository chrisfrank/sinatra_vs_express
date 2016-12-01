# start both web servers
pid = Process.spawn("foreman start")
# wait for them to spin up
sleep 5

# run Apache Bench against each server
servers = [
  { name: "Sinatra/Puma", port: 5000 },
  { name: "Express/Node", port: 5001 }
]
servers.each do |server|
  [10, 100, 1000].each do |page_size|
    puts "Benchmarking #{server[:name]} returning #{page_size} Posts..."
    command = "ab -n 2000 -c 50 http://127.0.0.1:#{server[:port]}/?page_size=#{page_size}"
    system command
    puts "... done"
  end
end

Process.kill("SIGTERM", pid)
puts "Benchmarks complete"
