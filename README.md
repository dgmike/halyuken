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
