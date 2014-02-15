module User::AuthDefinitions
  extend ActiveSupport::Concern
  
   included do

    # Include default devise modules. Others available are:
     
    # :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :confirmable, 
           :omniauthable, :token_authenticatable,
           :invitable

    ## Database authenticatable
    field :email,              :type => String, :default => ""
    field :encrypted_password, :type => String, :default => ""
    
    ## Recoverable
    field :reset_password_token,   :type => String
    field :reset_password_sent_at, :type => Time

    ## Rememberable
    field :remember_created_at, :type => Time

    ## Trackable
    field :sign_in_count,      :type => Integer, :default => 0
    field :current_sign_in_at, :type => Time
    field :last_sign_in_at,    :type => Time
    field :current_sign_in_ip, :type => String
    field :last_sign_in_ip,    :type => String

    ## Confirmable
    field :confirmation_token,   :type => String
    field :confirmed_at,         :type => Time
    field :confirmation_sent_at, :type => Time
    field :unconfirmed_email,    :type => String # Only if using reconfirmable

    ## Lockable
    # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
    # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
    # field :locked_at,       :type => Time

    ## Token authenticatable
    field :authentication_token, :type => String

    field :invitation_token, type: String
    field :invitation_created_at, type: Time
    field :invitation_sent_at, type: Time
    field :invitation_accepted_at, type: Time
    field :invitation_limit, type: Integer

    index( {invitation_token: 1}, {:background => true} )
    index( {invitation_by_id: 1}, {:background => true} ) 
    index({ email: 1 }, { background: true }) #unique: true, 


    # Password not required when using omniauth
    def password_required?
      super && identities.empty?
    end

    # Confirmation not required when using omniauth
    def confirmation_required?
      super && identities.empty?
    end

    def update_with_password(params, *options)
      if encrypted_password.blank?
        update_attributes(params, *options)
      else
        super
      end
    end

    # devise confirm! method overriden
    def confirm!
      welcome_message
      super
    end

    # devise_invitable accept_invitation! method overriden
    def accept_invitation!
      self.confirm!
      super
    end

    # devise_invitable invite! method overriden
    def invite!
      super
      self.confirmed_at = nil
      self.save
    end

    private

      def welcome_message
        UserMailer.welcome_message(self).deliver
      end

  end
end