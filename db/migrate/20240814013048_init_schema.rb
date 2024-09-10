class InitSchema < ActiveRecord::Migration[7.2]
  def change
    create_table :management_groups do |t|
      t.string :name

      t.timestamps
    end

    create_table :user_groups do |t|
      t.string :name
      t.references :management_group, null: false, foreign_key: true

      t.timestamps
    end

    create_enum :user_kinds,
      [ :tenant, :manager, :owner ]

    create_table :users do |t|
      t.string :display_name
      t.string :name, null: false
      t.string :phone_number
      t.string :email, null: false
      t.enum :kind,
             enum_type: :user_kinds,
             default: :tenant,
             null: false
      t.references :user_group, null: false, foreign_key: true

      t.timestamps
    end

    create_table :management_group_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :management_group, null: false, foreign_key: true
      t.boolean :admin, default: false, null: false
      t.boolean :active, default: true, null: false

      t.timestamps
    end

    add_index :management_group_users,
    [ :admin, :management_group_id ],
    where: "(admin IS TRUE)",
    unique: true,
    name: :management_group_users_single_admin_idx

    create_enum :property_kind,
    [ :single_family, :condo, :co_op, :townhome, :multi_family ]

    create_table :real_properties do |t|
      t.references :management_group, null: false, foreign_key: true
      t.string :address, null: false
      t.string :name
      t.enum :kind,
        enum_type: :property_kind,
        null: false

      t.timestamps
    end

    create_table :four_walls do |t|
      t.references :real_property, foreign_key: true, null: false
      t.string :name, null: false
    end

    create_enum :rental_kinds,
      [ :apartment, :bedroom, :condo, :house, :townhome, :multi_family ]

    create_table :rentals do |t|
      t.references :four_wall, null: false, foreign_key: true
      t.integer :rent_rate, null: false, default: 0
      t.boolean :available, default: false, null: false
      t.string :address, null: false
      t.string :parking_assignment
      t.string :primary_door_access_code
      t.string :secondary_door_access_code
      t.string :name, null: false
      t.enum :kind,
             enum_type: :rental_kinds,
             null: false

      t.timestamps
    end

    create_table :user_group_rentals do |t|
      t.references :user_group, null: false, foreign_key: true
      t.references :rental, null: false, foreign_key: true
      t.daterange :occupancy_range
      t.boolean :active, null: false,  default: false

      t.timestamps
    end

    create_enum :payment_statuses,
      [ :prompt, :early, :late,
        :overdue, :upcoming, :waived ]

    create_table :payment_transactions do |t|
      t.references :user_group_rental, null: false, foreign_key: true
      t.interval :occupancy_duration
      t.enum(:rent_payment_status,
              enum_type: :payment_statuses,
              default: :upcoming,
              null: false)
      t.datetime :rent_payment_due_date
      t.datetime :rent_payment_received_date
      t.integer :rent_amount

      t.enum(:utilities_payment_status,
              enum_type: :payment_statuses,
              default: :upcoming,
              null: false)
      t.datetime :utilities_payment_due_date
      t.datetime :utilities_payment_received_date
      t.integer :utilities_amount
      t.boolean :utilities_included, null: false

      t.timestamps
    end

    create_table :utility_groups do |t|
      t.references :four_wall, null: false, foreign_key: true
      t.datetime :date
      t.boolean :property_wide, default: false, null: false

      t.timestamps
    end

    create_table :utility_splits do |t|
      t.references :utility_group, null: false, foreign_key: true
      t.references :user_group_rental, null: false, foreign_key: true
      t.integer :split_rate
      t.interval :occupancy_duration
      t.integer :split_points
      t.integer :split_charge

      t.timestamps
    end

    create_enum :redistribution_strategies, [ :management, :roommates ]

    create_table :rent_exemptions do |t|
      t.references :user_group_rental, null: false, foreign_key: true
      t.references :management_group_user, null: false, foreign_key: true
      t.integer :exemption_percentage, default: 100, null: false
      t.datetime :exemption_expiration
      t.enum(:redistribution_strategy,
              enum_type: :redistribution_strategies,
              default: :management,
              null: false)
      t.text :reason

      t.timestamps
    end

    create_enum :utility_kind,
    [ :gas, :electric, :water, :internet, :trash ]

    create_table :utility_items do |t|
      t.references :utility_group, null: false, foreign_key: true

      t.enum :kind,
        enum_type: :utility_kind,
        null: false
      t.integer :total
      t.boolean :deffered, default: false, null: false

      t.timestamps
    end

    add_index :utility_items,
              [ :kind, :utility_group_id ],
              unique: true

    create_table :utility_exemptions do |t|
      t.references :utility_item, null: false, foreign_key: true
      t.references :user_group_rental, null: false, foreign_key: true
      t.references :management_group_user, null: false, foreign_key: true

      t.integer :exemption_percentage, default: 100, null: false
      t.datetime :exemption_expiration
      t.text :reason
      t.enum(:redistribution_strategy,
              enum_type: :redistribution_strategies,
              default: :management,
              null: false)

      t.timestamps
    end

    create_enum :property_event_kinds, [ :meeting, :party ]

    create_table :property_events do |t|
      t.boolean :mandatory, default: false, null: false
      t.references :user_group_rental, null: false, foreign_key: true # host
      t.boolean :property_wide
      t.enum :kind,
             enum_type: :property_event_kinds,
             default: :meeting,
             null: false
      t.text :description
      t.datetime :event_date
      t.string :location

      t.timestamps
    end

    create_enum :responses, [ :no, :yes, :maybe, :awaiting ]

    create_table :event_invitations do |t|
      t.references :invitee,
                    index: true,
                    foreign_key: { to_table: :users },
                    null: false
      t.references :inviter,
                    index: true,
                    foreign_key: { to_table: :users },
                    null: false
      t.references :property_event, null: false, foreign_key: true

      t.string :title
      t.text :description
      t.enum(:invite_response,
             enum_type: :responses,
             default: :maybe,
             null: false)

      t.timestamps
    end

    create_table :property_resources do |t|
      t.references :real_property, null: false, foreign_key: true
      t.string :name
      t.boolean :available, default: false, null: false

      t.timestamps
    end

    create_table :property_resource_items do |t|
      t.references :property_resource, null: false, foreign_key: true
      t.integer :starting_quantity
      t.integer :current_quantity
      t.integer :total_cost
      t.integer :total_length
      t.integer :total_width
      t.datetime :year
      t.date :expiration_date
      t.string :color
      t.boolean :available

      t.timestamps
    end

    create_table :chores do |t|
      t.references :user_group_rental, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.interval :frequency

      t.timestamps
    end

    create_table :grievances do |t|
      t.references :user_group_rental, null: false, foreign_key: true # author
      t.boolean :anonymous, default: true, null: false
      t.string :title
      t.text :description

      t.timestamps
    end

    create_enum :request_kinds, [ :repair, :reservation, :action ]

    create_table :requests do |t|
      t.references :user_group_rental, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.enum :kind,
             enum_type: :request_kinds,
             default: :repair,
             null: false
      t.datetime :appointment_date
      t.interval :duration

      t.timestamps
    end

    create_table :request_decisions do |t|
      t.references :request, null: false, foreign_key: true
      t.references :management_group_user, foreign_key: true, null: false
      t.boolean :granted
      t.text :explanation

      t.timestamps
    end

    create_table :rental_histories do |t|
      t.references :user_group_rental, null: false, foreign_key: true
      t.integer :rent_rate, null: false
      t.string :parking_assignment
      t.boolean :available
      t.datetime :date_of_change

      t.timestamps
    end
  end
end
