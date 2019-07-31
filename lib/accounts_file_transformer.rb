require 'matrix'

module Kata
  class AccountsFileTransformer

    LINES_PER_ENTRY           = 4
    CHARACTERS_PER_DIGIT      = 3
    DIGITS_PER_ACCOUNT_NUMBER = 9


    def process_accounts_file(file_path)
      account_entries    = extract_account_entries(file_path)
      account_numbers    = transform_account_entries(account_entries)
      number_validations = validate_account_numbers(account_numbers)

      account_numbers.zip(number_validations)
    end


    private


    def extract_account_entries(file_path)
      [].tap do |entries|
        File.readlines(file_path).each_slice(LINES_PER_ENTRY) do |account_number_lines|
          account_number_lines.delete_at(LINES_PER_ENTRY - 1) # Removing the empty account separation line
          account_number_lines.map!(&:chomp)                  # Removing the newline character

          account_number_characters = account_number_lines.join

          account_number_digits = [].tap do |digits|
            account_number_lines.count.times do
              DIGITS_PER_ACCOUNT_NUMBER.times do |digit_position|
                digits[digit_position] ||= ''
                digits[digit_position] << account_number_characters.slice!(0...CHARACTERS_PER_DIGIT)
              end
            end
          end

          entries << account_number_digits
        end
      end
    end

    def transform_account_entries(account_entries)
      account_entries.map do |account_digits|
        account_digits.map do |digit|

          case digit
            when '   ' +
                 '  |' +
                 '  |'
              '1'
            when ' _ ' +
                 ' _|' +
                 '|_ '
              '2'
            when ' _ ' +
                 ' _|' +
                 ' _|'
              '3'
            when '   ' +
                 '|_|' +
                 '  |'
              '4'
            when ' _ ' +
                 '|_ ' +
                 ' _|'
              '5'
            when ' _ ' +
                 '|_ ' +
                 '|_|'
              '6'
            when ' _ ' +
                 '  |' +
                 '  |'
              '7'
            when ' _ ' +
                 '|_|' +
                 '|_|'
              '8'
            when ' _ ' +
                 '|_|' +
                 ' _|'
              '9'
            else
              '?'
          end
        end.join
      end
    end

    def validate_account_numbers(account_numbers)
      account_numbers.map do |account_number|
        if account_number.include?('?')
          'illegible'
        else
          reversed_account_number_digits = account_number.reverse.chars.map(&:to_i)

          v1    = Vector[*reversed_account_number_digits]
          v2    = Vector[1, 2, 3, 4, 5, 6, 7, 8, 9]
          valid = (v1.inner_product(v2) % 11) == 0

          valid ? 'valid' : 'invalid'
        end
      end
    end

  end
end
