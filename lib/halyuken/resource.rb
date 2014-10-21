require 'halibut'
require 'json'

module Halyuken
  class Resource
    attr_accessor :resource

    def initialize(self_link, object)
      @resource = Halibut::Core::Resource.new
      @resource.link self_link, content_type: 'application/hal+json'
      object.each do |key, value|
        @resource.set_property key, value
      end
    end

    def embed(name, resource)
      resource = resource.resource if Halyuken::Resource == resource.class
      @resource.embed_resource name, resource
    end

    def push(name, resource)
      resource = resource.resource if Halyuken::Resource == resource.class
      @resource.add_embed_resource name, resource
    end

    def link(*attrs)
      @resource.add_link *attrs
    end

    def to_json
      Halibut::Adapter::JSON.dump @resource
    end

    def as_json
      ::JSON.parse to_json
    end
  end
end