class ApplicationController < ActionController::Base
  include DeviseWhitelist
  include CurrentUserConcern
end
