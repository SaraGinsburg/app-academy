
require 'addressable/uri'
require 'rest-client'

example_hash = {
  'id' => 5,
  'some_category' => {
    'a_key' => 'another value',
    'a_second_key' => 'yet another value',
    'inner_inner_hash' => {
      'key' => 'value'
    }
  },
  'something_else' => 'aaahhhhh'
}

url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users.json'
).to_s

begin
  puts RestClient.get(url)#, {user: {name: "Timothy Dalton", email: "TDalton@aol.com"}})
rescue RestClient::Exception => e
  puts e.message
end
