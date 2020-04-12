class Authenticate
  private_class_method :new

  def self.call(object, token, attr)
    new(obj, token, attr).send(:authenticated?)
  end

  private
    attr_reader :object, :token, :attr

    def initialize(object, token, attr)
      @object = object
      @token = token
      @attr = attr
    end

    def authenticated?
      digest = obj.send("#{attr}_digest")
      return false if digest.nil?
      BCrypt::Password.new(digest).is_password?(token)
    end

end
