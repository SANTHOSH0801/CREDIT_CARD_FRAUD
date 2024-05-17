-- Drop existing tables if they exist
DROP TABLE IF EXISTS transaction;
DROP TABLE IF EXISTS merchant;
DROP TABLE IF EXISTS credit_card;
DROP TABLE IF EXISTS card_holder;
DROP TABLE IF EXISTS merchant_category;

-- Merchant Category
CREATE TABLE merchant_category (
    id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

-- Card Holder
CREATE TABLE card_holder (
    id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

-- Credit Card
CREATE TABLE credit_card (
    card VARCHAR(20) NOT NULL,
    id_card_holder INT NOT NULL,
    PRIMARY KEY (card),
    CONSTRAINT fk_credit_card_id_card_holder FOREIGN KEY (id_card_holder) REFERENCES card_holder (id),
    CONSTRAINT check_credit_card_length CHECK (CHAR_LENGTH(card) <= 20)
);

-- Merchant
CREATE TABLE merchant (
    id INT AUTO_INCREMENT NOT NULL,
    name VARCHAR(255) NOT NULL,
    id_merchant_category INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_merchant_id_merchant_category FOREIGN KEY (id_merchant_category) REFERENCES merchant_category (id)
);

-- Transaction
CREATE TABLE transaction (
    id INT AUTO_INCREMENT NOT NULL,
    date TIMESTAMP NOT NULL,
    amount FLOAT NOT NULL,
    card VARCHAR(20) NOT NULL,
    id_merchant INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_transaction_card FOREIGN KEY (card) REFERENCES credit_card (card),
    CONSTRAINT fk_transaction_id_merchant FOREIGN KEY (id_merchant) REFERENCES merchant (id)
);
