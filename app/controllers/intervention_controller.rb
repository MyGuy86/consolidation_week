class InterventionController < ApplicationController
  skip_before_action :verify_authenticity_token


        ##################################################################
        # FreshDesk
        ##################################################################

        def create
        
          intervention = Intervention.create!(
            author: Employee.find(current_user.id),
            employee_id: params[:employee],
            elevator_id: params[:elevator],
            column_id: params[:column],
            battery_id: params[:battery],
            building_id: params[:building],
            customer_id: params[:customer],
            id: params[:id],
            result: "Incomplete",
            report: params[:projectdescription],
            status: "Pending"
              
          )
          userTitle = ""
          user = ""
          company = ""
          employeeName = ""


          Employee.all.each do|t|
            if t.id == intervention.author_id
              userTitle = t.title
            end
          end

          Employee.all.each do|u|
            if u.id == intervention.author_id
              user = u.email
            end
          end
          Employee.all.each do|t|
            if t.id == intervention.employee_id
              employeeName = t.first_name + " " + t.last_name
            end
          end
          Customer.all.each do |c|
            if c.id == intervention.customer_id
              company = c.CompanyName
            end
          end



          # Your freshdesk domain
          freshdesk_domain = 'https://codeboxx.freshdesk.com/api/v2/tickets'
      
          # It could be either your user name or api_key.
          api_key = ENV["freshdesk_api_key"]
          
          # If you have given api_key, then it should be x. If you have given user name, it should be password
  
          #attachments should be of the form array of Hash with files mapped to the key 'resource'.
          multipart_payload = { status: 2,
          priority: 1,
          type: "Problem",
          email: "#{user}",
          description: "THE FOLLOWING IS IN INTERVENTION BY #{userTitle} : 
          <p>Company- #{company}  
          <p>Building- #{intervention.building_id}
          <p>Battery- #{intervention.battery_id} 
          <p>Column- #{intervention.column_id == nil ? "none" : intervention.column_id} 
          <p>Elevator- #{intervention.elevator_id == nil ? "none" : intervention.elevator_id}
          <p>The Issue is: #{intervention.report}. 
          <p>#{employeeName} will be assigned to fix the issue",
          subject: "INTERVENTION",
          }.to_json
                              
                              
          site = RestClient::Resource.new(freshdesk_domain, api_key)
      
          begin
              response = site.post(multipart_payload, :content_type=>"application/json")
              puts "response_code: #{response.code} \n Location Header: #{response.headers[:Location]} \n response_body: #{response.body} \n"
          rescue RestClient::Exception => exception
              puts 'API Error: Your request is not successful. If you are not able to debug this error properly, mail us at support@freshdesk.com with the follwing X-Request-Id'
              puts "X-Request-Id : #{exception.response.headers[:x_request_id]}"
              puts "Response Code: #{exception.response.code} \nResponse Body: #{exception.response.body} \n"
          end
          #################################################################
          
          #################################################################
          redirect_to('/intervention')
        end   #end of create method 




















    def get_building_by_customer
        @buildings = Building.where("customer_id = ?", params[:customer_id])
        respond_to do |format|
          format.json { render :json => @buildings }
        end
      end

      def building_search
        if params[:customer_id].present? && params[:customer_id].strip != ""
          @buildings = Building.where("customer_id = ?", params[:customer_id])
        else
          @buildings = Building.all
        end
      end

        # +++++++++Battery+++++++++

      def get_battery_by_building
        @batteries = Battery.where("building_id = ?", params[:building_id])
        respond_to do |format|
          format.json { render :json => @batteries }
        end
      end

      def battery_search
        if params[:building_id].present? && params[:building_id].strip != ""
          @batteries = Battery.where("building_id = ?", params[:building_id])
        else
          @batteries = Battery.all
        end
      end



      # ++++++++++++COlUMN+++++++++++++


      def get_column_by_battery
        @columns = Column.where("battery_id = ?", params[:battery_id])
        respond_to do |format|
          format.json { render :json => @columns }
        end
      end

      def column_search
        if params[:battery_id].present? && params[:battery_id].strip != ""
          @columns = Column.where("battery_id = ?", params[:battery_id])
        else
          @columns = Column.all
        end
      end


      # ++++++++++++Elevator+++++++++++++


      def get_elevator_by_column
        @elevators = Elevator.where("column_id = ?", params[:column_id])
        respond_to do |format|
          format.json { render :json => @elevators }
        end
      end

      def elevator_search
        if params[:column_id].present? && params[:column_id].strip != ""
          @elevators = Elevator.where("column_id = ?", params[:column_id])
        else
          @elevators = Elevator.all
        end
      end
























# END OF LIFE
      end