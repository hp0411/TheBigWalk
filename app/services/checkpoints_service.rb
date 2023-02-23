module CheckpointsService
  CHECKPOINTS_START_COLUMN = 'C'
  CHECKPOINTS_COUNT = 21
  CHECKPOINTS_ROW = 3
  CHECKPOINTS_RANGE = "#{CHECKPOINTS_START_COLUMN}#{CHECKPOINTS_ROW}:#{(CHECKPOINTS_START_COLUMN.ord + CHECKPOINTS_COUNT - 1).chr}#{CHECKPOINTS_ROW}"
  CHECKPOINTS_SHEET_LONG = 'Long Walk Checkpoints Tracker'
  CHECKPOINTS_SHEET_SHORT = 'Short Walk Checkpoints Tracker'
  LAST_USER_CHECKPOINT_COLUMN_LONG = 'Y'
  LAST_USER_CHECKPOINT_COLUMN_SHORT = 'P'

  USER_ROW_OFFSET = 4

  def self.get_list_of_checkpoints(walk_type)
    begin
      checkpoints = []
      if walk_type == "long"
        checkpoints = SheetsService.get_range(CHECKPOINTS_SHEET_LONG, CHECKPOINTS_RANGE)
      else
        checkpoints = SheetsService.get_range(CHECKPOINTS_SHEET_SHORT, CHECKPOINTS_RANGE)
      end
      
      checkpoints.first
    rescue Google::Apis::ClientError => e
      if e.status_code == 403
        raise({
          code: 403,
          message: "The service account has not been given access to spreadsheet #{SPREADSHEET_ID}"
        })
      end
    end
  end

  ### This might be broken!
  def self.walker_help_needed
    SheetsService.update_cell_range(sheet_name, cell1, cell2, values) #("Need Help", "B10", "J10", [["10","Broken leg"]]) Example!
  end
  ### End of code

  def self.checkin(checkpoint, user_number)
    checkpoint_column = self.checkpoint_id_number_to_column(checkpoint.number)

    if checkpoint.walk_type == 'long'
      SheetsService.update_single_cell(CHECKPOINTS_SHEET_LONG, "#{checkpoint_column}#{user_number + USER_ROW_OFFSET - 10}", Time.new.strftime('%H:%M'))
      SheetsService.update_single_cell(CHECKPOINTS_SHEET_LONG, "#{LAST_USER_CHECKPOINT_COLUMN_LONG}#{user_number + USER_ROW_OFFSET - 10}", checkpoint.number)
    else
      SheetsService.update_single_cell(CHECKPOINTS_SHEET_SHORT, "#{checkpoint_column}#{user_number + USER_ROW_OFFSET}", Time.new.strftime('%H:%M'))
      SheetsService.update_single_cell(CHECKPOINTS_SHEET_SHORT, "#{LAST_USER_CHECKPOINT_COLUMN_SHORT}#{user_number + USER_ROW_OFFSET}", checkpoint.number)
    end
  end

  private

  # checkpoint_number [1,2,3, so on] starts from 1
  def self.checkpoint_id_number_to_column(checkpoint_number)
    (CHECKPOINTS_START_COLUMN.ord + checkpoint_number.to_i - 1).chr
  end
end
