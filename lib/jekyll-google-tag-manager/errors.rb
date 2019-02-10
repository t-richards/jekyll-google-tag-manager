# frozen_string_literal: true

module Jekyll
  class GoogleTagManager
    # The base class from which other exceptions are derived
    class Error < StandardError; end

    # Raised when an invalid tag section is specified
    class InvalidSectionError < Error; end
  end
end
