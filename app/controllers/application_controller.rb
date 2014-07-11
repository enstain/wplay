class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :make_action_mailer_use_request_host_and_protocol
  helper_method :current_company
  before_filter :goaway_unregister

  def after_sign_in_path_for(resource)
    case resource.class.name
      when 'God'
        "/adminka"
      when 'Admin'
        control_index_path(subdomain: resource.company.subdomain)
      else
        worker_path(resource, subdomain: resource.company.subdomain)
      end
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path(subdomain: false)
  end

  def current_company
    Company.where(subdomain: current_subdomain).first
  end
  
  private
  def make_action_mailer_use_request_host_and_protocol
    ActionMailer::Base.default_url_options[:protocol] = request.protocol
    ActionMailer::Base.default_url_options[:host] = request.host
  end

  private
  def goaway_unregister
    if current_subdomain
      if current_company == nil
        redirect_to root_path(subdomain: false)
      else
        unless worker_signed_in? || admin_signed_in? || devise_controller?
          redirect_to new_worker_session_path(subdomain: current_subdomain)
        end
      end
    else
      if devise_controller? && request.path != "/gods/sign_in" && request.path != "/gods/sign_out"
        redirect_to root_path(subdomain: false)
      end
    end
  end
end
