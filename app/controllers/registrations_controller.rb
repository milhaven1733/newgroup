class RegistrationsController < Devise::RegistrationsController
  def new 
    build_resource({})
    yield resource if block_given?

    respond_to do |format|
      format.mobile { render "new.mobile.slim" }
      format.html { render "new.html.erb" }
    end 
  end

  def create
    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      RegistrationMail.new_venue_notification(resource).deliver_later if resource.role == 'merchant'
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        redirect_to after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        redirect_to after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
    
      respond_to do |format|
        format.mobile { render "new.mobile.slim" }
        format.html { render "new.html.erb" }
      end 
    end
  end
end
