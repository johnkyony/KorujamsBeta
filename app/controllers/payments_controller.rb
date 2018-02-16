class PaymentsController < ApplicationController
  before_action :set_project
  
  skip_before_action :verify_authenticity_token
  include OffsitePayments::Integrations
  
  def index
    
  end
  
  def paid
    create_notification('f@cus1sbr1ght21')
    
    if @notification.acknowledge
      if @notification.complete?
       
        # the saving into the payments database
         payment_successfull_data = Payment.new
         payment_successfull_data.pf_payment_id = @notification.transaction_id
         payment_successfull_data.payment_status = @notification.status

         payment_successfull_data.save 
         if payment_successfull_data.save
          flash[:notice] = "This is a successful transaction"
          redirect_to root_path
         end
         
         
        
      else
       flash[:sucess] = "This is a failure of a transaction"
      redirect_to root_path
      end
      
    else
      head :bad_request
    end
  end

  def success
     flash[:notice] = "This is a successful transaction"
    redirect_to root_path
  end

  def fail
  end
  
  private
  
  def set_project
    @project = Project.find_by_id(params[:project_id])
    
  end
  
  def set_project_milestone
    @project_milestone = ProjectMilestone.find(params[:project_milestone_id])
    
  end
  
  def create_notification(password)
    @notification = OffsitePayments.integration(:pay_fast).notification(request.raw_post, secret: Rails.configuration.offsite_payments['payfast']['password'])
  end
end
