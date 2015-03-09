require 'rails_helper'

RSpec.describe ApplicationController, :type => :controller do

  controller do
    def index
      head :ok
    end
  end

  describe "#ref_to_cookie" do

    context "when no ref code in url" do

      it "doesn't set cookie" do
        get :index
        expect(cookies[:h_ref]).to be_nil
      end

    end

    context "when there is ref in url" do

      before { allow(controller).to receive(:_routes).and_return(@routes) }

      it "sets ref code in cookie when it's in url and it is valid" do
        user = FactoryGirl.create(:user)
        get :index, ref: user.referral_code
        expect(cookies[:h_ref]).to eq(user.referral_code)
      end

      it "doesn't set code when there's no user who owns it" do
        get :index, ref: "xxxxxxx"
        expect(cookies[:h_ref]).to be_nil
      end
    end
  end
end

