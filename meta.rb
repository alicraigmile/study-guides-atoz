#!/usr/bin/ruby
require 'rubygems'
require 'json'
require 'pp'
require 'date'
require 'erb'

class ListController
  def initialize(list)
    @list = list
  end

  # This is only a helper method to access
  # the object's (private) binding method
  def get_binding
    binding
  end
end


template = 'meta.erb'
file = 'meta.json'
baseUrl = 'http://www.test.bbc.co.uk/education/guides'

json = File.read(file)
obj = JSON.parse(json)

list = Array.new

obj['contents'].each do |item| 
  title = item['title']
  fileId = item['fileId']
  name = item['createdBy']['name']
  email = item['createdBy']['email']

  datetimeString = item['modifiedDateTime']
  datetime = DateTime.parse(datetimeString)
  modifiedDate = datetime.strftime('%d/%m/%Y')

  url = "#{baseUrl}/#{fileId}"
  emailUrl = "mailto:#{email}"

  list.push({
    :title        => title,
    :fileId       => fileId,
    :url          => url,
    :name         => name,
    :email        => email,
    :emailUrl     => emailUrl,
    :modifiedDate => modifiedDate
  })

end

  controller = ListController.new(list)

  renderer = ERB.new(File.read(template))
  puts output = renderer.result(controller.get_binding)

