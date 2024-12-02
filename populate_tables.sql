-- Insert sample data into Users table
INSERT INTO Users (username, email, password_hash, phone_number)
VALUES
  ('user1', 'user1@mailpay.com', '$2a$10$...', '+1 555-1234'),
  ('user2', 'user2@mailpay.com', '$2a$10$...', '+1 555-5678'),
  ('user3', 'user3@mailpay.com', '$2a$10$...', '+1 555-9012');

-- Insert sample data into Transactions table
INSERT INTO Transactions (user_id, amount, payment_method, transaction_status)
VALUES
  (1, 50.00, 'Credit Card', 'completed'),
  (2, 100.00, 'PayPal', 'pending'),
  (3, 75.00, 'Debit Card', 'failed');

-- Insert sample data into Notifications table
INSERT INTO Notifications (user_id, title, message)
VALUES
  (1, 'New Transaction', 'You have a new completed transaction.'),
  (2, 'Password Reset', 'Your password has been reset successfully.'),
  (3, 'KYC Verification', 'Your KYC verification is pending.');

-- Insert sample data into Settings table
INSERT INTO Settings (user_id, setting_name, setting_value)
VALUES
  (1, 'theme', 'dark'),
  (2, 'notification_preferences', 'email'),
  (3, 'language', 'en');

-- Insert sample data into KYC_Verifications table
INSERT INTO KYC_Verifications (user_id, document_type, document_number, verification_status)
VALUES
  (1, 'Passport', 'AB1234567', 'approved'),
  (2, 'Driver\'s License', 'XYZ9876', 'pending'),
  (3, 'National ID', 'PQR5432', 'rejected');

-- Insert sample data into Support_Requests table
INSERT INTO Support_Requests (user_id, subject, description, status)
VALUES
  (1, 'Transaction Issue', 'I am unable to complete a transaction.', 'open'),
  (2, 'Account Question', 'How do I update my profile information?', 'in-progress'),
  (3, 'KYC Verification', 'I need help with my KYC verification.', 'closed');