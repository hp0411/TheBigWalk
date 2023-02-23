require "google/apis/sheets_v4"
require 'google/apis/drive_v3'

module SheetsService
  # This is the Google Spreadsheet that is used by our app
  # To test with you own spreadsheet you need to create a Spreadsheet in your account, 
  # then share it with the service account email, and then replace this id with your spreadsheet's id.

  # To delete these:
  # SheetsService.update_single_cell(CHECKPOINTS_SHEET, "#{PICK_COLUMN}#{value_id.to_i + USER_ROW_OFFSET}", "TRUE")
  # SPREADSHEET_ID = '1Qhb7zKKtFQq8zoE4cc8Wemc_Gp7Xocj3CiGJk42KRp4'

  SPREADSHEET_ID = '1eu_ULrod_7nqAYA-cEodU7TEuDXr6SoqcCoD4rwA03w'
  HELP_SHEET = 'Need Help'
  CHECKPOINTS_SHEET = 'Checkpoints Tracker'
  LONGWALK = 'Long Walk Checkpoints Tracker'
  SHORTWALK = 'Short Walk Checkpoints Tracker'
  USER_ROW_OFFSET = 3
  ID_COLUMN = 'B'
  REASON_COLUMN = 'C'
  NOTES_COLUMN = 'D'
  ORDER_COLUMN = 'E'
  TIME_COLUMN = 'G'
  SEVER_COLUMN = 'H'
  PHONE_COLUMN = 'I'
  NEEDS_COLUMN = 'J'
  PICK_COLUMN = 'M'

  # This authorizes our service account with both sheets and drive. We probably dont need both.
  def self.authorize
    # drive_service = Google::Apis::DriveV3::DriveService.new
    sheets_service = Google::Apis::SheetsV4::SheetsService.new

    scope = 'https://www.googleapis.com/auth/drive'

    authorizer = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open('./softwarehut-344011-11d1a408fc0f.json'),
      scope: scope)

    # drive.authorization = authorizer
    sheets_service.authorization = authorizer

    return sheets_service
  end

  def self.get_last_row(sheet_name, column)
    sheets_service = self.authorize
    sheet_range = "#{column}1:#{column}5000"
    column_values = self.get_range(sheet_name, sheet_range)
    
    column_values.length
  end

  def self.get_range(sheet_name, range)
    sheets_service = self.authorize
    sheet_range = "#{sheet_name}!#{range}"

    sheets_service.get_spreadsheet_values(SPREADSHEET_ID, sheet_range).values
  end

  # sheet_name - a sheet in the spreadsheet
  # cell - the cell to update A1, B2, etc.

  #Cell Update function; updates a single cell with a value inputted from a form by a runner.
  def self.update_single_cell(sheet_name, cell, value)
    range = "#{sheet_name}!#{cell}:#{cell}"
    sheets_service = self.authorize
    value_object = { 
      majorDimension: 'ROWS',
      values: [[value]]
    }
    return sheets_service.update_spreadsheet_value(SPREADSHEET_ID, range, value_object, value_input_option: 'USER_ENTERED')

  end

  def self.update_cell_range(sheet_name, cell1, cell2, values)
    range = "#{sheet_name}!#{cell1}:#{cell2}"
    sheets_service = self.authorize
    value_object = { 
      majorDimension: 'ROWS',
      values: values
    }
    sheets_service.update_spreadsheet_value(SPREADSHEET_ID, range, value_object, value_input_option: 'USER_ENTERED')
  end

  #Drop-Out function; When runner presses Drop-Out, deletes any entry of them in the Help sheet.
  #def self.update_dropout(value_id, walk_type)
  #  sheets_service = self.authorize
  ##  sheets_service.sheet_id = 4
    #x = 1
   # [1...sheets_service.size].each {
  #    if(sheets_service.input_value[x,2] == value_id)
     #   SheetsService.deleteDimension(CHECKPOINTS_SHEET, 'ROWS', x, x)
      #else 
#        x = x + 1
 #     end
  #  }
  #end

    def self.dropout(value_id, walk_type)
      sheets_service = self.authorize
      if walk_type == "long"
        return SheetsService.update_single_cell(LONGWALK, "AA#{value_id.to_i + USER_ROW_OFFSET + 1}", "TRUE")
      else
        return SheetsService.update_single_cell(SHORTWALK, "R#{value_id.to_i + USER_ROW_OFFSET + 1}", "TRUE")
      end
  end

  #Help Sheet function; When runner presses Help, they choose the issue and are added onto the Help sheet alongside any information.
  def self.update_cell_help(value_id, value_pick, value_sev, value_notes, value_issue, value_phone, value_needs)
    sheets_service = self.authorize
    # sheets_service.sheet_range = CHECKPOINTS_SHEET
    row = 1 + self.get_last_row(HELP_SHEET,"B")
    # sheets_service.insert_rows(get_last_row, 1)

    SheetsService.update_single_cell(HELP_SHEET, "#{ID_COLUMN}#{row}", value_id)
    SheetsService.update_single_cell(HELP_SHEET, "#{REASON_COLUMN}#{row}", value_issue)
    SheetsService.update_single_cell(HELP_SHEET, "#{NOTES_COLUMN}#{row}", value_notes)
    SheetsService.update_single_cell(HELP_SHEET, "#{ORDER_COLUMN}#{row}", value_sev)
    SheetsService.update_single_cell(HELP_SHEET, "#{TIME_COLUMN}#{row}", Time.new.strftime('%H:%M'))
    SheetsService.update_single_cell(HELP_SHEET, "#{SEVER_COLUMN}#{row}", value_sev)
    SheetsService.update_single_cell(HELP_SHEET, "#{PHONE_COLUMN}#{row}", value_phone)
    result = SheetsService.update_single_cell(HELP_SHEET, "#{NEEDS_COLUMN}#{row}", value_needs)
    return result
  
  end

  # def self.update_cell_time(sheet_name, cell, value)
  #   range = "#{sheet_name}!#{cell}:#{cell}"
  #   sheets_service = self.authorize
  #   value_type = {
  #     majorDimension: 'ROWS',
  #     values: [[value]]
  #   }
    
  #   worksheet.set_number_format(cell, "TIME")
  #   sheets_service.update_spreadsheet_value(SPREADSHEET_ID, cell, value_type, value_input_option: 'USER_ENTERED')
  # end
end
