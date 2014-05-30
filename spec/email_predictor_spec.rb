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

    context "given a person's workplace with available data" do

      it "should return an array" do
        expect(ep.predict_email).to be_kind_of(Array)
      end

      context "for alphasights employees" do
        it "should return the proper email" do
          expect( ep.predict_email("Peter Wong", "alphasights.com") ).to eq("peter.wong@alphasights.com")
        end
      end
      
      context "for google employees" do
        it "should return two different email versions" do
          expect( ep.predict_email("Craig Silverstein", "google.com").size ).to eq(2)
        end

        it "should return the proper email for alphasight employees" do
          let(:google_result) { ep.predict_email("Craig Silverstein", "google.com") }

          expect( google_result ).to eq( ["craig.s@google.com", "c.silverstein@google.com" ] )
        end
      end

      

      # "Craig Silverstein", "google.com"
# "Steve Wozniak", "apple.com"
# "Barack Obama", "whitehouse.gov"

    end

    # context "given a person's workplace where the data is not available" do

    # end

    # context "for cases where the email cannot be accurately predicted" do
    #   it "should output all possible emails" do

    #   end
    # end

  end

  
end