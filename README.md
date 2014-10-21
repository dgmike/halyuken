# Halyuken

Generate simple hal+json responses for Rails Framework

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'halyuken'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install halyuken

## Usage

Use `Halyuken::Resource` to create your resources:

```ruby
object = { name: 'Michael' }
resource = Halyuken::Resource.new '/link_to_resource', object
```

Use `render_hal` to render your resource.

This gem register `hal` as `application/hal+json` as mimetype in Rails.

Follow code shows a rails controller sample.

```ruby
class WelcomeController < ActionController::Base

  def index
    @bookmark = { name: 'dgmike', url: 'http://dgmike.com.br' }
    @author = { id: 1, name: 'Michael' }
    @categories = [{id: 1, name: 'programming'}, {id: 2, name: 'technology'}]

    respond_to do |format|
      format.html { render body: "<a href='#{@bookmark[:url]}'>#{@bookmark[:name]}</a>" }
      format.hal { render_hal bookmark_resource }
    end
  end

  private

    def bookmark_resource
      resource = Halyuken::Resource.new '/bookmarks/1', resourceType: :bookmark, bookmark: @bookmark
      resource_author = Halyuken::Resource.new '/authors/1', @author

      resource.link :doc, '/doc/bookmarks'

      resource.embed :author, resource_author
      @categories.each do |category|
        resource_category = Halyuken::Resource.new "/category/#{category[:id]}", category
        resource.push :categories, resource_category
      end

      resource
    end

end
```

And, as response you get:

```
curl -D - -H 'Accept':'application/hal+json' http://localhost:3000
```

```javascript
HTTP/1.1 200 OK
Content-Type: application/hal+json; charset=utf-8
Content-Length: 404

{"resourceType":"bookmark","bookmark":{"name":"dgmike","url":"http://dgmike.com.br"},"_links":{"self":{"href":"/bookmarks/1"},"doc":{"href":"/doc/bookmarks"}},"_embedded":{"author":{"id":1,"name":"Michael","_links":{"self":{"href":"/authors/1"}}},"categories":[{"id":1,"name":"programming","_links":{"self":{"href":"/category/1"}}},{"id":2,"name":"technology","_links":{"self":{"href":"/category/2"}}}]}}
```