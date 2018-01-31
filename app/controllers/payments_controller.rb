class PaymentsController < ApplicationController
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
         payment_successfull_data.project_milestone_id = @project_milestone.id 
         payment_successfull_data.item_name = @project_milestone.title + "Feature"
         payment_successfull_data.save 
         if payment_successfull_data.save
           render nothing: true
         end
         
         
        
      else
        render nothing: true
      end
      
    else
      head :bad_request
    end
  end

  def success
  end

  def fail
  end
  
  private
  
  def set_project_milestone
    @project_milestone = ProjectMilestone.find(params[:project_milestone_id])
    
  end
  
  def create_notification(password)
    @notification = OffsitePayments.integration(:pay_fast).notification(request.raw_post, secret: Rails.configuration.offsite_payments['payfast']['password'])
  end
end
