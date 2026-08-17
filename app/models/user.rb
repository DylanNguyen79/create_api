class User < ApplicationRecord
    has_secure_password
    validates :email, presence: true, uniqueness: true

      has_many :owned_projects,
           class_name: "Project",
           foreign_key: "owner_id"
end
