require_relative '../lib/accounts_file_transformer'

input_file     = ARGV[0]
output_file    = ARGV[1]
processed_data = Kata::AccountsFileTransformer.new.process_accounts_file(input_file)

File.open(output_file, 'w') do |file|
  processed_data.each do |account_data|
    account_number  = account_data.first
    validation_code = case account_data.last
                        when 'valid'
                          ''
                        when 'invalid'
                          ' ERR'
                        when 'illegible'
                          ' ILL'
                        else
                          raise "Unknown validation type '#{account_data.last}'"
                      end

    file.print account_number
    file.print validation_code
    file.print "\n"
  end
end
