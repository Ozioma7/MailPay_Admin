-- Create Users table
CREATE TABLE Users (
  id SERIAL PRIMARY KEY,
  firstname VARCHAR(50) NOT NULL,
  lastname VARCHAR(50) NOT NULL,
  username VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  email_verified_at TIMESTAMP,
  password_hash VARCHAR(255) NOT NULL,
  phone_number VARCHAR(20) UNIQUE NOT NULL,
  status VARCHAR(20) DEFAULT 'active', -- active, inactive, banned
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Accounts table
CREATE TABLE Accounts (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL UNIQUE,
  transaction_pin VARCHAR(10) NOT NULL,
  currency VARCHAR(10) DEFAULT 'NGN',
  account_number VARCHAR(20) UNIQUE NOT NULL,
  balance DECIMAL(15, 2) DEFAULT 0.00,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(id)
);

-- Create Transactions table
CREATE TABLE Transactions (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  transaction_reference VARCHAR(100) NOT NULL UNIQUE,
  transaction_type VARCHAR(20) CHECK (transaction_type IN ('credit', 'debit', 'transfer', 'purchase')),
  amount DECIMAL(15, 2) NOT NULL,
  transaction_fee DECIMAL(10, 2) DEFAULT 0.00,
  payment_method VARCHAR(50),
  transaction_status VARCHAR(20) CHECK (transaction_status IN ('pending', 'completed', 'failed')),
  remark TEXT,
  recipient_id INT, -- For internal transfers
  beneficiary_account VARCHAR(50), -- Account number of the beneficiary
  beneficiary_name VARCHAR(100), -- Name of the beneficiary
  beneficiary_bank VARCHAR(100), -- Bank name for the beneficiary
  service_provider VARCHAR(100), -- e.g., Airtel, MTN, PHCN
  service_details TEXT, -- e.g., meter number, phone number
  service_fee DECIMAL(10, 2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(id),
  FOREIGN KEY (recipient_id) REFERENCES Users(id)
);

-- Create Notifications table
CREATE TABLE Notifications (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  title VARCHAR(100) NOT NULL,
  message TEXT NOT NULL,
  action_url TEXT,
  read BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(id)
);

-- Create Settings table
CREATE TABLE Settings (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  setting_name VARCHAR(50) NOT NULL,
  setting_value VARCHAR(100) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(id)
);

-- Create KYC_Verifications table
CREATE TABLE KYC_Verifications (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  document_type VARCHAR(50) NOT NULL,
  document_number VARCHAR(50) NOT NULL,
  date_of_birth DATE NOT NULL,
  verification_status VARCHAR(20) CHECK (verification_status IN ('pending', 'approved', 'rejected')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(id)
);

-- Create Support_Request_Types table
CREATE TABLE Support_Request_Types (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  description TEXT
);

-- Create Support_Requests table
CREATE TABLE Support_Requests (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  support_request_type_id INT NOT NULL,
  subject VARCHAR(100) NOT NULL,
  description TEXT NOT NULL,
  status VARCHAR(20) CHECK (status IN ('open', 'closed', 'in-progress')),
  resolution_time TIMESTAMP,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(id),
  FOREIGN KEY (support_request_type_id) REFERENCES Support_Request_Types(id)
);

-- Create Password_Resets table
CREATE TABLE Password_Resets (
  id SERIAL PRIMARY KEY,
  email VARCHAR(100) NOT NULL,
  token VARCHAR(100) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Pin_Reset_Logs table
CREATE TABLE Pin_Reset_Logs (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  old_pin VARCHAR(10),
  new_pin VARCHAR(10) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(id)
);

-- Create OTPs table
CREATE TABLE OTPs (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL,
  otp_code VARCHAR(10) NOT NULL,
  expires_at TIMESTAMP NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES Users(id)
);

