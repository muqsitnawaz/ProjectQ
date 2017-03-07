class Question < ActiveRecord::Base
  # Search engine stuff
  include SearchCop

  search_scope :csearch do
    attributes :content, :detail, :topics
  end
  
  belongs_to :user
  has_many :answers

  serialize :topics
  serialize :followers

  # Validations
  #validates_associated :user
  #validates :content, presence: true, length: { minimum: 5, maximum: 50 }
  #validates :detail, presence: true, length: { minimum: 5 }
#to delete

Questions = [
  'Which is the best cell phone network in ',
  'Which phone sells most in ',
  'What are the major concerns when moving to ',
  'Things to keep in mind when getting settled in ',
  'Who is most popular personality of ',
]


 MAPPING = {
    "content" => "content",
    "user_id" => "user_id",
    'anonymous' => 'anonymous',
    'topics' => 'topics'
  }

  def self.import(file)
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      Questions.each do |q|
        (2..spreadsheet.last_row).each do |i|
          row = Hash[[header, spreadsheet.row(i)].transpose]
          # Convert the keys from the csv to match the database column names
          row.keys.each { |k| row[ MAPPING[k] ] = row.delete(k) if MAPPING[k] }
          # Remove company and phone number fields as these aren't in the database:
          puts row.inspect
          if !row.nil?
            # row.update(row){|key,v1| "What are the most profitable businesses in "+v1}
            row[:topics] = ['General Knowledge','Visiting and Travel'];
            row[:content] = (q + row.values[0])
             puts 'inspection'
              puts row.inspect
            row[:content] = row[:content].parameterize  
            question = Question.create(row)
            question.save
          end
        end
      end
  end
  
  #helper method for import
  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
      when ".csv" then Roo::CSV.new(file.path, file_warning: :ignore)
      when ".xls" then Roo::Excel.new(file.path, file_warning: :ignore)
      when ".xlsx" then Roo::Excelx.new(file.path, file_warning: :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end
end