class HelpController < ApplicationController

   #Test
   def create 
      result = SheetsService.update_cell_help(params["walker"], params["pickup"], params["severity"], params["notes"], params["description"], params["number"], params["needs"])
      redirect_to(
        controller: 'checkin', 
        action: 'index', 
        errors: result.updated_cells == 1 ? nil : "error",
        success: result.updated_cells == 1 ? "Help Message Sent" : result.updated_cells
      )
      
   end

end

