#!/usr/bin/ruby
require 'rubygems'
require 'socket'
require 'mysql2'

webserver = TCPServer.new('0.0.0.0', 6789)

client = Mysql2::Client.new(
  :host => "127.0.0.1",
  :username => "root",
  :password => "mysql",
  :database => "mydb"
)

records = client.query("SELECT * FROM users")

while (session = webserver.accept)
   session.print "HTTP/1.1 200/OK\r\nContent-type:text/html\r\n\r\n"
   request = session.gets
   records.each {|r| session.print "<p>#{r['name']} - #{r['age']}</p>"}
   session.close
 end
