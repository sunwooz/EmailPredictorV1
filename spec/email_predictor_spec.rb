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
  let(:ep) { EmailPredictor.new(training_data) }

  describe "#initialize" do

    context "given training data that is a hash" do

      it "#training_data should be a hash" do
        expect(ep.training_data).to be_kind_of(Hash)
      end 

    end

  end

  describe "#predict_email" do

    context "given a person's workplace with available data" do

      it "should return an array" do
        expect(ep.predict_email("Sunwoo Yang", "google.com")).to be_kind_of(Array)
      end

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
        expect( unavailable_workplace ).to eq("No data availble for whatever.com")
      end

    end

  end

  describe "#data_available?" do

    it "should return false when workplace doesn't exist in training data" do
      expect( ep.send(:data_available?, "whatever.com") ).to be_false
    end

    it "should return true when workplace does exist in training data" do
      expect( ep.send(:data_available?, "google.com") ).to be_true
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

  describe "#determine_workplace" do

    context "given an email" do
      let(:workplace) { ep.send(:determine_workplace, "yangsunwoo@alphasights.com") }

      it "should return workplace.com" do
        expect( workplace ).to eq("alphasights.com")
      end

    end

  end

  describe "pattern checkers" do
    let(:f_name) { "sunwoo" }
    let(:l_name) { "yang" }

    describe "#check_first_name_dot_last_name" do
      let(:fndln_email) { "sunwoo.yang@gmail.com" }
      let(:fndln_pattern) { ep.send(:check_first_name_dot_last_name, f_name, l_name, fndln_email) }

      it "should return the name of the pattern" do
        expect( fndln_pattern ).to eq("first_name_dot_last_name")
      end
    end

    describe "#check_first_name_dot_last_initial" do
      let(:fndli_email) { "sunwoo.y@gmail.com" }
      let(:fndli_pattern) { ep.send(:check_first_name_dot_last_initial, f_name, l_name, fndli_email) }

      it "should return the name of the pattern" do
        expect( fndli_pattern ).to eq("first_name_dot_last_initial")
      end
    end

    describe "#check_first_initial_dot_last_name" do
      let(:fidln_email) { "s.yang@gmail.com" }
      let(:fidln_pattern) { ep.send(:check_first_initial_dot_last_name, f_name, l_name, fidln_email) }

      it "should return the name of the pattern" do
        expect( fidln_pattern ).to eq("first_initial_dot_last_name")
      end
    end

    describe "#check_first_initial_dot_last_initial" do
      let(:fidli_email) { "s.y@gmail.com" }
      let(:fidli_pattern) { ep.send(:check_first_initial_dot_last_initial, f_name, l_name, fidli_email) }

      it "should return the name of the pattern" do
        expect( fidli_pattern ).to eq("first_initial_dot_last_initial")
      end
    end

  end

  describe "#convert_pattern_to_email" do
    let(:f_name) { "sunwoo" }
    let(:l_name) { "yang" }
    let(:work_domain) { "google.com" }

    context "given first_name_dot_last_name" do
      let(:fndln_pattern) { "first_name_dot_last_name" }
      let(:converted_fndln) do
        ep.send(:convert_pattern_to_email, f_name, l_name, fndln_pattern, work_domain)
      end

      it "should return sunwoo.yang@google.com" do
        expect( converted_fndln ).to eq("sunwoo.yang@google.com")
      end
    end

    context "given first_name_dot_last_initial" do
      let(:fndli_pattern) { "first_name_dot_last_initial" }
      let(:converted_fndli) do
        ep.send(:convert_pattern_to_email, f_name, l_name, fndli_pattern, work_domain)
      end

      it "should return sunwoo.y@google.com" do
        expect( converted_fndli ).to eq("sunwoo.y@google.com")
      end
    end

    context "given first_initial_dot_last_name" do
      let(:fidln_pattern) { "first_initial_dot_last_name" }
      let(:converted_fidln) do
        ep.send(:convert_pattern_to_email, f_name, l_name, fidln_pattern, work_domain)
      end

      it "should return s.yang@google.com" do
        expect( converted_fidln ).to eq("s.yang@google.com")
      end
    end

    context "given first_initial_dot_last_name" do
      let(:fidli_pattern) { "first_initial_dot_last_initial" }
      let(:converted_fidli) do
        ep.send(:convert_pattern_to_email, f_name, l_name, fidli_pattern, work_domain)
      end

      it "should return s.y@google.com" do
        expect( converted_fidli ).to eq("s.y@google.com")
      end
    end

  end
  
end