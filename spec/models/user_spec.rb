require 'rails_helper'

RSpec.describe User, :type => :model do
  
  describe "validations" do

    it "validates with proper params" do
      expect(FactoryGirl.build(:user)).to be_valid
    end

    it "fails to validate without email" do
      expect(FactoryGirl.build(:user, email: nil)).to_not be_valid
    end

    it "fails to validate when email is not unique" do
      FactoryGirl.create(:user, email: "test@prelaunchr.com")
      expect{ FactoryGirl.create(:user, email: "test@prelaunchr.com") }.to raise_error(
        ActiveRecord::RecordInvalid, /Email has already been taken/
      )
    end

    it "fails to validate when email is in invalid format" do
      [ "Abc.example.com", "A@b@c@example.com", "just'not'right@example.com", 
        "not\allowed@example.com", "john..doe@example.com", "john.doe@example..com"  ].each do |invalid_email|
        expect(FactoryGirl.build(:user, email: invalid_email)).to_not be_valid
      end
    end

    it "validates with proper email" do
      [ "niceandsimple@example.com", "very.common@example.com", "a.little.lengthy.but.fine@dept.example.com",
        "disposable.style.email.with+symbol@example.com", "email-with-dash@example.com" ].each do |valid_email|
        expect(FactoryGirl.build(:user, email: valid_email)).to be_valid
      end
    end

    it "fails to validate without referral code" do
      expect(FactoryGirl.build(:user, referral_code: nil)).to_not be_valid
    end

    it "has unique refferal code" do
      FactoryGirl.create(:user, referral_code: "0123456789")
      expect{ FactoryGirl.create(:user, referral_code: "0123456789") }.to raise_error(ActiveRecord::RecordNotUnique)
    end

    it "fails to validate without referrer id" do
      expect(FactoryGirl.build(:user, referrer_id: nil)).to_not be_valid
    end
  end
end
