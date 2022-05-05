# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def set_final
    Rails.logger.debug("HOLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL\n")
    @variable = 123
  end
end
