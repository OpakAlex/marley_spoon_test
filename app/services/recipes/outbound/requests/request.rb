# frozen_string_literal: true

module Recipes
  module Outbound
    module Requests
      module Request
        def self.included(base)
          base.class_eval do
            include ResponseMethods
            attr_accessor :response
          end
        end

        module ResponseMethods
          def response_successful?
            @response.success?
          end
        end
      end
    end
  end
end
