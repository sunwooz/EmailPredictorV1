require_relative 'spec_helper'
require_relative '../email_predictor'

describe EmailPredictor do
  let(:training_data) do
    {
      "John Ferguson" => "john.ferguson@alphasights.com",
      "Damon Aw" => "damon.aw@alphasights.com",
      "Linda Li" => "linda.li@alphasights.com",
      "Larry Page" => "larry.p@google.com",
      "Sergey Brin" => "s.brin@google.com",
      "Steve Jobs" => "s.j@apple.com"
    }
  end

  describe "#initialize" do
    context "given training data that is a hash" do
      let(:training_data) { { "test" => "data" } }
      let(:ep) { EmailPredictor.new(training_data) }

      it "#training_data should be a hash" do
        expect(ep.training_data).to be_kind_of(Hash)
      end 
    end
  end

  describe "#predict_email" do
    let(:ep) { EmailPredictor.new(training_data) }

    context "given a person's workplace where the data is available" do

      it "should return the proper email for google employees" do
        expect( ep.predict_email("Peter Wong", "alphasights.com") ).to eq("peter.wong@alphasights.com")
      end

    end

    # context "given a person's workplace where the data is not available" do

    # end

    # context "for cases where the email cannot be accurately predicted" do
    #   it "should output all possible emails" do

    #   end
    # end

  end

  
end