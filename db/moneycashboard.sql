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
 value INT2,
 merchant_id INT8 REFERENCES merchants(id),
 tag_id INT8 REFERENCES tag(id)
);