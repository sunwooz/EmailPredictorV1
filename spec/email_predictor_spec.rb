require_relative 'spec_helper'
require_relative '../model/email_predictor'


describe EmailPredictor do
  let(:workplace_email_formats) do
    {
      "alphasights.com" => [:first_name_dot_last_name],
      "google.com" => [ :first_name_dot_last_initial, :first_initial_dot_last_name],
      "apple.com" => [:first_initial_dot_last_initial]
    }
  end
  
  let(:ep) { EmailPredictor.new(workplace_email_formats) }

  describe "#predict_email" do

    context "given a person's workplace with available data" do

      context "for alphasights employees" do
        it "should return the proper email" do
          expect( ep.predict_email("Peter Wong", "alphasights.com") ).to eq(["peter.wong@alphasights.com"])
        end
      end
      
      context "for google employees" do
        let(:google_result) { ep.predict_email("Craig Silverstein", "google.com") }

        it "should return an array with two results" do
          expect( google_result.size ).to eq(2)
        end

        it "should return the proper email" do
          expect( google_result ).to eq( ["craig.s@google.com", "c.silverstein@google.com" ] )
        end
      end

      context "for apple employees" do
        let(:apple_result) { ep.predict_email("Steve Jobs", "apple.com") }

        it "should return the proper email" do
          expect( apple_result ).to eq(["s.j@apple.com"])
        end
      end

    end

    context "given a person's workplace where the data is not available" do
      let(:unavailable_workplace) { ep.predict_email("Sunwoo Yang", "whatever.com") }

      it "should return 'No data availble for whatever.com'" do
        expect( unavailable_workplace ).to eq("No data available for whatever.com")
      end

    end

  end

  describe "#split_name" do
    let(:a_split_name) { ep.send(:split_name, "Sunwoo Yang") }

    it "should return an array" do
      expect( a_split_name ).to be_kind_of(Array)
    end

    it "should return two elements" do
      expect( a_split_name.size ).to eq(2)
    end
  end

  describe "#convert_pattern_to_email" do
    let(:f_name) { "sunwoo" }
    let(:l_name) { "yang" }
    let(:work_domain) { "google.com" }

    context "given first_name_dot_last_name" do
      let(:fndln_pattern) { :first_name_dot_last_name }
      let(:converted_fndln) do
        ep.send(:convert_pattern_to_email, f_name, l_name, fndln_pattern, work_domain)
      end

      it "should return sunwoo.yang@google.com" do
        expect( converted_fndln ).to eq("sunwoo.yang@google.com")
      end
    end

    context "given first_name_dot_last_initial" do
      let(:fndli_pattern) { :first_name_dot_last_initial }
      let(:converted_fndli) do
        ep.send(:convert_pattern_to_email, f_name, l_name, fndli_pattern, work_domain)
      end

      it "should return sunwoo.y@google.com" do
        expect( converted_fndli ).to eq("sunwoo.y@google.com")
      end
    end

    context "given first_initial_dot_last_name" do
      let(:fidln_pattern) { :first_initial_dot_last_name }
      let(:converted_fidln) do
        ep.send(:convert_pattern_to_email, f_name, l_name, fidln_pattern, work_domain)
      end

      it "should return s.yang@google.com" do
        expect( converted_fidln ).to eq("s.yang@google.com")
      end
    end

    context "given first_initial_dot_last_name" do
      let(:fidli_pattern) { :first_initial_dot_last_initial }
      let(:converted_fidli) do
        ep.send(:convert_pattern_to_email, f_name, l_name, fidli_pattern, work_domain)
      end

      it "should return s.y@google.com" do
        expect( converted_fidli ).to eq("s.y@google.com")
      end
    end

  end
  
end