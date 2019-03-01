module Concerns::Messages
  extend ActiveSupport::Concern

  def error message:, code: nil
    ImmutableStruct.new(:error,
                        :code)
        .new(error: message,
             code: code)
  end
end