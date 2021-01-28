class UnauthenticatedController < ApplicationController
  skip_before_action :authenticate, :check_verification
end
