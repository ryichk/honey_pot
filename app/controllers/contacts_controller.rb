class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    # add field for honey pot.
    if params[:contact][:address].present?
      send_alert
      log_honeypot
      redirect_to root_path
      return
    end

    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:success] = "Contact successfully created"
      redirect_to thanks_contacts_path
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def thanks
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end

  def log_honeypot
    Rails.logger.info("Honeypot triggered at #{Time.now.utc}. IP address: #{request.remote_ip}")
  end

  def send_alert

  end
end
