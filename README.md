# Final MailPay Mobile Database Schema Documentation

## Overview
The database schema for the Final MailPay Mobile application consists of six main tables:

1. **Users**
2. **Transactions**
3. **Notifications**
4. **Settings**
5. **KYC_Verifications**
6. **Support_Requests**

These tables store the necessary data for the various functionalities of the Final MailPay Mobile application, including user management, transaction management, notifications, settings, KYC verification, and support requests.

## Entity Relationship Diagram (ERD)

```
+------------+          +---------------+
|    Users   |          |  Transactions |
+------------+          +---------------+
| user_id (PK)|          | transaction_id(PK)|
|  username  |          |    user_id (FK)|
|    email   |          |      amount   |
| password_hash|         | payment_method|
| phone_number|         |  transaction_status|
| created_at |          |   created_at  |
| updated_at |          |   updated_at  |
+------------+          +---------------+
      |                         |
      |                         |
+------------+          +---------------+
|  Notifications|        | KYC_Verifications|
+------------+          +---------------+
| notification_id(PK)|   |  verification_id(PK)|
|    user_id (FK)|       |    user_id (FK)|
|       title   |       | document_type |
|     message   |       | document_number|
|       read    |       | verification_status|
|   created_at  |       |   created_at  |
+------------+          |   updated_at  |
                         +---------------+
      |                         |
      |                         |
+------------+          +---------------+
| Support_Requests|      |     Settings  |
+------------+          +---------------+
|   request_id (PK)|     |   setting_id (PK)|
|    user_id (FK)|       |    user_id (FK)|
|      subject   |       |  setting_name |
|   description  |       |  setting_value|
|       status   |       |   created_at  |
|   created_at   |       |   updated_at  |
|   updated_at   |       +---------------+
+------------+          
```

## Data Types
- `user_id`, `transaction_id`, `notification_id`, `verification_id`, `request_id`, `setting_id`: `INTEGER` (auto-incrementing)
- `username`, `email`, `password_hash`, `phone_number`, `title`, `message`, `document_type`, `document_number`, `subject`, `description`, `setting_name`, `setting_value`: `VARCHAR`
- `amount`: `DECIMAL(10,2)`
- `transaction_status`: `VARCHAR(20)`
- `verification_status`: `VARCHAR(20)`
- `status`: `VARCHAR(20)`
- `read`: `BOOLEAN`
- `created_at`, `updated_at`: `TIMESTAMP`

## Relationships
- One-to-many relationship between Users and Transactions, Users and Notifications, Users and Settings, Users and KYC_Verifications, Users and Support_Requests.

## Constraints
### Users Table
- `user_id`: Primary Key
- `email`: UNIQUE
- `phone_number`: UNIQUE
- `password_hash`: NOT NULL

### Transactions Table
- `transaction_id`: Primary Key
- `user_id`: Foreign Key referencing Users table
- `transaction_status`: CHECK constraint to ensure valid statuses (e.g., 'pending', 'completed', 'failed')

### Notifications Table
- `notification_id`: Primary Key
- `user_id`: Foreign Key referencing Users table
- `read`: BOOLEAN constraint

### Settings Table
- `setting_id`: Primary Key
- `user_id`: Foreign Key referencing Users table

### KYC_Verifications Table
- `verification_id`: Primary Key
- `user_id`: Foreign Key referencing Users table
- `verification_status`: CHECK constraint to ensure valid statuses (e.g., 'pending', 'approved', 'rejected')

### Support_Requests Table
- `request_id`: Primary Key
- `user_id`: Foreign Key referencing Users table
- `status`: CHECK constraint to ensure valid statuses (e.g., 'open', 'closed', 'in-progress')

## SQL Scripts

The database schema is divided into two SQL script files:

1. `create_tables.sql`: Contains the SQL statements to create the necessary tables.
2. `populate_tables.sql`: Contains optional SQL statements to insert sample data into the tables for testing purposes.

The scripts can be executed using a database management tool like pgAdmin or the command line interface (psql).

## Usage

1. Run the `create_tables.sql` script to create the database tables.
2. (Optional) Run the `populate_tables.sql` script to insert sample data into the tables for testing purposes.
3. Use the created tables to store and retrieve data for the Final MailPay Mobile application.


### Users Table
The Users table stores the user's personal information, including their username, email, hashed password, and phone number. The primary key for this table is the `user_id` column, which is an auto-incrementing integer. The `email` and `phone_number` columns are unique to ensure that each user has a unique email address and phone number.

### Transactions Table
The Transactions table stores information about the financial transactions made by the users. Each transaction is identified by a unique `transaction_id`, and is associated with a `user_id` (foreign key referencing the Users table). The table also stores the `amount`, `payment_method`, and `transaction_status` of the transaction. The `transaction_status` column has a CHECK constraint to ensure that only valid statuses (e.g., 'pending', 'completed', 'failed') can be stored.

### Notifications Table
The Notifications table stores the notifications sent to the users. Each notification is identified by a unique `notification_id`, and is associated with a `user_id` (foreign key referencing the Users table). The table also stores the `title`, `message`, and `read` status of the notification. The `read` column has a BOOLEAN constraint to indicate whether the notification has been read by the user.

### Settings Table
The Settings table stores the user-specific settings. Each setting is identified by a unique `setting_id`, and is associated with a `user_id` (foreign key referencing the Users table). The table stores the `setting_name` and `setting_value` for each setting.

### KYC_Verifications Table
The KYC_Verifications table stores the information related to the user's KYC (Know Your Customer) verification process. Each verification is identified by a unique `verification_id`, and is associated with a `user_id` (foreign key referencing the Users table). The table stores the `document_type`, `document_number`, and `verification_status` of the KYC verification. The `verification_status` column has a CHECK constraint to ensure that only valid statuses (e.g., 'pending', 'approved', 'rejected') can be stored.

### Support_Requests Table
The Support_Requests table stores the information about the support requests submitted by the users. Each request is identified by a unique `request_id`, and is associated with a `user_id` (foreign key referencing the Users table). The table stores the `subject`, `description`, and `status` of the support request. The `status` column has a CHECK constraint to ensure that only valid statuses (e.g., 'open', 'closed', 'in-progress') can be stored.

This detailed documentation provides a comprehensive understanding of the database schema design for the Final MailPay Mobile application, including the purpose, relationships, and constraints of each table. The SQL scripts provided can be used to create and populate the tables for testing and development purposes.
