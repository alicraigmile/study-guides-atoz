#!/usr/bin/ruby
require 'rubygems'
require 'json'
require 'pp'
require 'date'
require 'erb'

#template = 'meta.erb'
file = 'meta.json'
baseUrl = 'http://www.test.bbc.co.uk/education/guides'

json = File.read(file)
obj = JSON.parse(json)

print "<link rel=\"stylesheet\" type=\"text/css\" href=\"meta.css\">"
print "<table>"
print "<tr><td>Title</td><td>ID</td><td>Author</td><td>Published</td></tr>"

obj['contents'].each do |item| 
  title = item['title']
  fileId = item['fileId']
  name = item['createdBy']['name']
  email = item['createdBy']['email']

  d_string = item['modifiedDateTime']
  d = DateTime.parse(d_string)
  date = d.strftime('%d/%m/%Y')

  url = "#{baseUrl}/#{fileId}"
  email_url = "mailto:#{email}"

  #puts "<p><a href=\"#{url}\">#{title}</a> (#{fileId}) by <a href=\"#{email_url}\">#{name} &lt;#{email}&gt;</a> on #{date}.</p>\n"
  puts "<tr><td><a href=\"#{url}\">#{title}</a></td><td><a href=\"#{url}\">#{fileId}</a></td><td><a href=\"#{email_url}\">#{name}</a></td><td>#{date}</td></tr>\n"

end


  #renderer = ERB.new(template)
  #puts output = renderer.result)

puts "</table>"
