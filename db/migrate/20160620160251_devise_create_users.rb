class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      # Main fields
      t.string :profile_pic
      t.string :name,               null: false, default: ""
      t.boolean :is_admin,          default: false
      t.boolean :completed,         default: false

      # Personal info
      t.text :education,            default: []
      t.text :interests,            default: []
      t.text :knows_about,          default: []
      t.text :employments,          default: []
      t.string :location,           default: ""
      
      t.text :answers_upvote,               default: []
      t.text :answers_downvote,             default: []

      # List of questions a user is following
      t.text :following,            default: []

      # Cause related info
      t.text :causes_agreed,          default: []
      t.text :causes_disagreed,       default: []
      t.text :causes_followed,        default: []
      
      # Other fields
      t.boolean :read,                default: true
      t.integer :profile_views,       default: 0

      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      # Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
