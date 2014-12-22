class SessionsController < Devise::SessionsController
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?

    respond_to do |format|
      format.mobile { render "new.mobile.slim" }
      format.html { render "new.html.erb" }
    end
  end
end
