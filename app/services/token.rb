module Token
    def self.digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def self.new_token
      SecureRandom.urlsafe_base64
    end
end
