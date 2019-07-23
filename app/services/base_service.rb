# frozen_string_literal: true

require 'dry/monads/do'
require 'dry/monads/result'

class BaseService
  include Dry::Monads::Result::Mixin

  def call(**args)
    _call(args)
  rescue Dry::Monads::Do::Halt => e
    e.result
     .rescue StandardError => e
    Failure(e)
  end

  private

  def _call(**_args)
    raise NotImplementedError
  end

  def validate(contract, params)
    result = contract.new.call(params)
    if result.success?
      Success(result.to_h)
    else
      Failure(result.errors.to_h)
    end
  end
end
