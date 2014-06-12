require_relative 'spec_helper'
require_relative '../model/pattern_finder'

describe PatternFinder do
  let(:training_data) do
    {
      "Larry Page" => "larry.p@google.com",
      "Sergey Brin" => "s.brin@google.com"
    }
  end
  let(:pf) { PatternFinder.new(training_data) }

  context "#parse_data" do

    it "should return the first_name_dot_last_initial format" do
      expect( pf.parse_data['google.com'] ).to include( :first_name_dot_last_initial )
    end

    it "should return the first_initial_dot_last_name format" do
      expect( pf.parse_data['google.com'] ).to include( :first_initial_dot_last_name )
    end

  end

  
  # describe "pattern checkers" do
  #   let(:f_name) { "sunwoo" }
  #   let(:l_name) { "yang" }

  #   describe "#check_first_name_dot_last_name" do
  #     let(:fndln_email) { "sunwoo.yang@gmail.com" }
  #     let(:fndln_pattern) { ep.send(:check_first_name_dot_last_name, f_name, l_name, fndln_email) }

  #     it "should return 'first_name_dot_last_name'" do
  #       expect( fndln_pattern ).to eq("first_name_dot_last_name")
  #     end
  #   end

  #   describe "#check_first_name_dot_last_initial" do
  #     let(:fndli_email) { "sunwoo.y@gmail.com" }
  #     let(:fndli_pattern) { ep.send(:check_first_name_dot_last_initial, f_name, l_name, fndli_email) }

  #     it "should return 'first_name_dot_last_name'" do
  #       expect( fndli_pattern ).to eq("first_name_dot_last_initial")
  #     end
  #   end

  #   describe "#check_first_initial_dot_last_name" do
  #     let(:fidln_email) { "s.yang@gmail.com" }
  #     let(:fidln_pattern) { ep.send(:check_first_initial_dot_last_name, f_name, l_name, fidln_email) }

  #     it "should return 'first_initial_dot_last_name'" do
  #       expect( fidln_pattern ).to eq("first_initial_dot_last_name")
  #     end
  #   end

  #   describe "#check_first_initial_dot_last_initial" do
  #     let(:fidli_email) { "s.y@gmail.com" }
  #     let(:fidli_pattern) { ep.send(:check_first_initial_dot_last_initial, f_name, l_name, fidli_email) }

  #     it "should return 'first_initial_dot_last_initial'" do
  #       expect( fidli_pattern ).to eq("first_initial_dot_last_initial")
  #     end
  #   end

  # end


end