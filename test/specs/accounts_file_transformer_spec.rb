require_relative '../spec_helper'


RSpec.describe Kata::AccountsFileTransformer do

  let(:test_directory) { Kata::FileHelper.create_directory }


  context 'with a single account number' do

    let(:input_file) { Kata::FileHelper.create_file(directory: test_directory,
                                                    name:      'accounts',
                                                    extension: '.dat',
                                                    text:      ['    _  _     _  _  _  _  _ ',
                                                                '  | _| _||_||_ |_   ||_||_|',
                                                                '  ||_  _|  | _||_|  ||_| _|',
                                                                ''].join("\n")) }
    let(:account_numbers) { [123456789] }

    it 'processes a file of scanned account numbers to regular numbers' do
      account_numbers_found = subject.process_accounts_file(input_file).map { |account_number_data| account_number_data.first }
      expect(account_numbers_found).to eq(account_numbers)
    end

  end

  context 'with multiple account numbers' do

    let(:input_file) { Kata::FileHelper.create_file(directory: test_directory,
                                                    name:      'accounts',
                                                    extension: '.dat',
                                                    text:      ['    _  _     _  _  _  _  _ ',
                                                                '  | _| _||_||_ |_   ||_||_|',
                                                                '  ||_  _|  | _||_|  ||_| _|',
                                                                '',
                                                                '    _  _     _  _  _  _  _ ',
                                                                '  | _| _||_||_ |_   ||_||_|',
                                                                '  ||_  _|  | _||_|  ||_| _|',
                                                                ''].join("\n")) }
    let(:account_numbers) { [123456789, 123456789] }

    it 'processes a file of scanned account numbers to regular numbers' do
      account_numbers_found = subject.process_accounts_file(input_file).map { |account_number_data| account_number_data.first }
      expect(account_numbers_found).to eq(account_numbers)
    end

  end

  context 'with a valid account number' do
    let(:input_file) { Kata::FileHelper.create_file(directory: test_directory,
                                                    name:      'accounts',
                                                    extension: '.dat',
                                                    text:      ['    _  _     _  _  _  _  _ ',
                                                                '  | _| _||_||_ |_   ||_||_|',
                                                                '  ||_  _|  | _||_|  ||_| _|',
                                                                ''].join("\n")) }

    let(:result) { [[123456789, 'valid']] }

    it 'identifies the account number as valid' do
      expect(subject.process_accounts_file(input_file)).to eq(result)
    end

  end

  context 'with an invalid account number' do

    let(:input_file) { Kata::FileHelper.create_file(directory: test_directory,
                                                    name:      'accounts',
                                                    extension: '.dat',
                                                    text:      ['    _  _     _  _  _  _  _ ',
                                                                '  | _| _||_||_ |_   ||_||_|',
                                                                '  ||_  _|  | _||_|  ||_||_|',
                                                                ''].join("\n")) }

    let(:result) { [[123456788, 'invalid']] }

    it 'identifies the account number as invalid' do
      expect(subject.process_accounts_file(input_file)).to eq(result)
    end

  end

end
