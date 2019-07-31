require_relative '../spec_helper'
require 'open3'


RSpec.describe 'the executable' do

  let(:test_directory) { Kata::FileHelper.create_directory }
  let(:input_file) { Kata::FileHelper.create_file(directory: test_directory,
                                                  name:      'accounts',
                                                  extension: '.dat',
                                                  text:      ['    _  _     _  _  _  _  _ ',
                                                              '  | _| _||_||_ |_   ||_||_|',
                                                              '  ||_  _|  | _||_|  ||_| _|',
                                                              ''].join("\n")) }

  let(:executable_path) { "#{__dir__}/../../exe/process_accounts.rb" }
  let(:command) { "bundle exec ruby #{executable_path} #{input_file}" }

  let(:results) { std_out, std_err, status = [nil, nil, nil]

                  Dir.chdir(test_directory) do
                    std_out, std_err, status = Open3.capture3(command)
                  end

                  { std_out: std_out, std_err: std_err, status: status } }


  it 'processes a file of scanned account numbers to regular numbers' do
    expect(results[:std_out]).to eq("123456789 valid\n")
  end

end
