rquerystring
============

A hash to url query string generator and url query string to hash parser gem


##Installation

```bash
$ gem install rquery_string
```
Or with Bundler in your Gemfile.

```
gem 'google_play_search'
```

##Usage

```ruby

RqueryString.build({:a => 1, "b" => "2", :c => 2.5})
=> "a=1&%27b%27=%272%27&c=2.5"

RqueryString.parse("a=1&%27b%27=%272%27&c=2.5")                
=> {:a=>1, "b"=>"2", :c=>2.5}

RqueryString.build({:a => [1,2,3], :b => "1"})
=> "a[]=1&a[]=2&a[]=3&b=%271%27"

RqueryString.parse("a[]=1&a[]=2&a[]=3&b=%271%27")  
=> {:a=>[1, 2, 3], :b=>"1"}


```
