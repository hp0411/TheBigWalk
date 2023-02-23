class TestCheckController < ApplicationController
    def index
    end
    
    def show
    end
  
    # { 
    #   row: integer
    #   column: integer  
    #   value: some value
    # }
    # Example { row: 1, column: A, value: some value } -> this puts some value into A1
    def create
      
      SheetsService.update_cell_time('Sheet1', "#{params[:column]}#{params[:row]}", params[:value])
    end
  end