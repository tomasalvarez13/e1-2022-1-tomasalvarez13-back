# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    render 'home', status: :ok, formats: [:json]
  end
end
