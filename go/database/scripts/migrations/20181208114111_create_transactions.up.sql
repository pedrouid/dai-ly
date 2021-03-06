CREATE TABLE transactions (
  id                serial                        PRIMARY KEY NOT NULL,
  tx_hash           text                          NOT NULL UNIQUE,
  sender            text                          NOT NULL,
  receiver          text                          NOT NULL,
  delegate          text                          NOT NULL,
  signature         text                          NOT NULL,
  fee_amount        text                          NOT NULL,
  send_amount       text                          NOT NULL,
  token             text                          NOT NULL,
  nonce             text                          NOT NULL,
  status            text                          NOT NULL DEFAULT 'QUEUED',
  submitted_hash    text                          ,
  last_created      timestamp with time zone      NOT NULL DEFAULT current_timestamp,
  last_modified     timestamp with time zone      NOT NULL DEFAULT current_timestamp
);

CREATE OR REPLACE FUNCTION update_last_modified_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.last_modified = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_transactions_modtime BEFORE UPDATE ON transactions FOR EACH ROW EXECUTE PROCEDURE update_last_modified_column();
