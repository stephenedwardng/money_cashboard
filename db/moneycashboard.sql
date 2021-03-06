DROP TABLE transactions;
DROP TABLE tags;
DROP TABLE merchants;

CREATE TABLE merchants (
  id SERIAL8 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE tags (
  id SERIAL8 PRIMARY KEY,
  type VARCHAR(255)
);

CREATE TABLE transactions (
 id SERIAL8 PRIMARY KEY,
 item VARCHAR(255),
 value FLOAT,
 merchant_id INT8 REFERENCES merchants(id) ON DELETE CASCADE,
 tag_id INT8 REFERENCES tags(id) ON DELETE CASCADE,
 date_of_transaction DATE
);