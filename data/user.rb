class User < ApplicationRecord
  include Passpartu
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  belongs_to :organization
  has_many :projects
  has_many :specifications
  has_many :estimations

  enum role: %i[worker manager admin]
end
