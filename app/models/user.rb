class User < ActiveRecord::Base
  has_many :routes
  has_many :tasks, dependent: :destroy
  
  belongs_to :role, class_name: "UserRole"
  belongs_to :state, class_name: "UserState"
  
  
  # Esta llamada invoca una operacion antes de guardar el objeto en la BD.
  # Se usa para asegurar la unicidad del correo a nivel de base de datos.
  before_save { self.email = email.downcase }
  
  # Esta llamada invoca una operacion antes de crear el objeto, que luego se guardara en la BD
  # before_create :create_remember_token
  
  # Controles para el registro (http://ruby.railstutorial.org/chapters/modeling-users)
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  
  
  
  # Defino el manejo de roles
  # ID_ADMIN = 1
  # ID_EDITOR = 2
  # ID_OBSERVADOR = 3
  ROLES = %w[admin editor observador]

  def role?(base_role)
    ROLES.index(base_role.to_s) + 1 >= role.id # Creanme que funciona :D
  end
  
  
  
  # Defino los procedimientos necesarios para generar y guardar el token asociado a la sesion del usuario
  # Las operaciones definidas como User.xxx son estaticas, no necesitan una instancia
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    # Se encripta el token usando SHA1, es menos seguro que Bcrypt (usado para contraseñas, pero mas rapido)
    # La llamada a token.to_s asegura poder manejar valores nil, no deberia suceder en navegadores web,
    # pero a veces puede darse en los tests.
    Digest::SHA1.hexdigest(token.to_s)
  end
  
  private
    # Crea el token asociado al usuario para iniciar automaticamente su sesion
    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token())
    end
    
    
end
