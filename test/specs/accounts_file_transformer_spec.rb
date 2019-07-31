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
    let(:expected_results) { [123456789] }

    it 'processes a file of scanned account numbers to regular numbers' do
      expect(subject.process_accounts_file(input_file)).to eq(expected_results)
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
    let(:expected_results) { [123456789, 123456789] }

    it 'processes a file of scanned account numbers to regular numbers' do
      expect(subject.process_accounts_file(input_file)).to eq(expected_results)
    end

  end

end
