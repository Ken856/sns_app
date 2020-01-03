require 'rails_helper'

RSpec.describe "UserSignins", type: :request do
  describe "signup" do
    it "invalid signup" do
      post users_path, params: {user: {
        name: "", email: "hoge@invalid", password: "hoge", password_confirmation: "hoge"
      }}
      expect(response).to render_template :new
    end

  #   it "valid signup" do
  #     post users_path, params: {user: {
  #       name: "Aaron", email: "hoge@example.com", password: "hogehoge", password_confirmation: "hogehoge"
  #       }}
  #     expect(response).to render_template("/users/show")
  #   end
  end
end
