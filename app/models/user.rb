class User < ApplicationRecord
  attr_accessor :remember_token

  # user has many posts and comments association
  has_many :events, foreign_key: 'creator_id', dependent: :destroy

  has_many :attendances, foreign_key: 'attendee_id', dependent: :destroy
  has_many :attended_events, through: 'attendances', source: 'attended_event'


  #hooks
  before_save :downcase_fields

  #email regex for valid email
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  #name validation
  validates :name, presence: true, 
                       length: {maximum: 50}
                
  #email validation
  validates :email, presence: true, 
                    uniqueness: {case_sensitive: false}, 
                    format: {with: EMAIL_REGEX},
                    length: {maximum: 255}

  has_secure_password

  # validates password
  validates :password, presence: true,
                       length: {minimum: 6}

  
  def authenticated?(token)
    return unless remember_digest
    BCrypt::Password.new(remember_digest).is_password?(token)
  end

  def remember
    self.remember_token = User.new_token
    self.update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  def forget
    self.update_attribute(:remember_digest, nil)
  end

  #/// CLASS METHODS ////#

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  private
  
    def downcase_fields
      self.email.downcase!
      self.name.downcase!
    end

end

