class User < ActiveRecord::Base
    has_many :articles, dependent: :destroy
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: {maximum: 50}
    validates :email, presence: true, 
                      length: {maximum: 250}, 
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
    has_secure_password

    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
            BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
end
