Mime::Type.register "application/hal+json", :hal unless Mime[:hal]

module Halyuken
  class ActionController::Base

    protected

      def render_hal(resource)
        resource = resource.as_json if Halyuken::Resource == resource.class
        render json: resource, content_type: Mime::HAL
      end

  end
end

ActionController::Base.send(:include, Halyuken)
