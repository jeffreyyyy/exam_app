class Teacher < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name,  :presence => true,
                    :length   => { :maximum => 65, :minimum => 5 }
  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }
                       
  before_save :encrypt_password
  
  def has_password?(submitted_password)
    # Compare encrypt_password with the encrypted version of submitted password.
  end
  
  private
  
    def encrypt_password
      self.encrypted_password = encrypt(password)
    end
    
    def encrypt(string)
      string # Left off on 7.2.3 - Implementing has_password?
    end
  
end
