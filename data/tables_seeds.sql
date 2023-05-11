-- Drop tables if they exist
DROP TABLE IF EXISTS peeps_users;
DROP TABLE IF EXISTS peeps;
DROP TABLE IF EXISTS users;

-- Create users table
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email text NOT NULL UNIQUE,
  password text NOT NULL,
  name text,
  username text NOT NULL UNIQUE
);

-- Create peeps table
CREATE TABLE peeps (
  id SERIAL PRIMARY KEY,
  message text,
  timestamp timestamp DEFAULT CURRENT_TIMESTAMP,
  user_id int REFERENCES users(id)
);

-- Create peeps_users table for the many-to-many relationship
CREATE TABLE peeps_users (
  peep_id int REFERENCES peeps(id),
  user_id int REFERENCES users(id),
  PRIMARY KEY (peep_id, user_id)
);

-- Insert sample data
INSERT INTO users (email, password, name, username)
VALUES
  ('hello@gmail.com', 'password', 'Bob', 'bob678'),
  ('fred@gmail.com', '123', 'Fred', 'freddo');

INSERT INTO peeps (message, user_id)
VALUES
  ('Hello world! This is Bob.', 1),
  ('I just posted a great peep.', 2),
  ('Bob, your peep is awesome!', 1),
  ('Tagging Fred in this peep!', 2);

INSERT INTO peeps_users (peep_id, user_id)
VALUES
  (4, 1);
