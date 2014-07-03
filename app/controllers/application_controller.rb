class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :make_action_mailer_use_request_host_and_protocol

  def after_sign_in_path_for(resource)
  	if resource.class.name == 'Admin'
	  control_index_path
	else
	  worker_path(resource)
	end
  end
  
  private

  def make_action_mailer_use_request_host_and_protocol
    ActionMailer::Base.default_url_options[:protocol] = request.protocol
    ActionMailer::Base.default_url_options[:host] = request.host
  end
end
