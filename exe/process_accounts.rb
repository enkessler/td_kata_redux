require_relative '../lib/accounts_file_transformer'

puts Kata::AccountsFileTransformer.new.process_accounts_file(ARGV[0])
