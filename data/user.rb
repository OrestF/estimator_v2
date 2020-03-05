class User < ApplicationRecord
  include Passpartu

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :organization
  has_many :projects
  has_many :specifications
  has_many :estimations

  enum role: {
    worker: 0,
    sales_manager: 1,
    client: 2,
    solution_architect: 3,
    business_analyst: 4,
    organization_manager: 5,
    admin: 1024
  }

  enum domain: {
    non_tech: 0,
    ruby: 1,
    js: 2,
    react_native: 3,
    python: 4,
    design: 5,
    pm: 6,
    php: 7
  }
end
