-- Join tables first
DROP TABLE IF EXISTS Holdings; 
DROP TABLE IF EXISTS PurchasesItems;

-- Then main tables
DROP TABLE IF EXISTS Assets;
DROP TABLE IF EXISTS Accounts;
DROP TABLE IF EXISTS Purchases;
DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS Stores;
DROP TABLE IF EXISTS Expenses;

CREATE TABLE Accounts (
    Account_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    type VARCHAR(100),
    cash_balance NUMERIC(15,2),
    contribution_limit NUMERIC(15,2)
);

CREATE TABLE Assets (
    Asset_id SERIAL PRIMARY KEY,
    ticker VARCHAR(20) NOT NULL,
    title VARCHAR(255),
    type VARCHAR(100),
    MER NUMERIC(5,2),
    dividend_yield NUMERIC(5,2),
    number_of_Holdingss INT,
    price_to_earnings NUMERIC(10,2),
    currency VARCHAR(10),
    exchange VARCHAR(50),
    current_price NUMERIC(15,2),
    last_updated_on TIMESTAMP
);

-- Middle table for Accounts <-> Assets
CREATE TABLE Holdings (
    Account_id INT REFERENCES Accounts(Account_id) ON DELETE CASCADE,
    Asset_id INT REFERENCES Assets(Asset_id) ON DELETE CASCADE,
    shares NUMERIC(15,4),
    average_purchase_price NUMERIC(15,4),
    PRIMARY KEY (Account_id, Asset_id)
);

CREATE TABLE Expenses (
    Expense_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    currency VARCHAR(10),
    is_taxable BOOLEAN,
    description TEXT,
    yearly_charges NUMERIC(15,2),
    monthly_charges NUMERIC(15,2),
    biweekly_charges NUMERIC(15,2)
);

CREATE TABLE Stores (
    Store_id SERIAL PRIMARY KEY,
    brand VARCHAR(100),
    street_number INT,
    street_name VARCHAR(255),
    postal_code VARCHAR(20)
);

CREATE TABLE Items (
    Item_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    brand VARCHAR(100),
    Store_id INT REFERENCES Stores(Store_id) ON DELETE SET NULL,
    quantity NUMERIC(15,4),
    unit VARCHAR(50),
    per_unit_applicable BOOLEAN,
    is_taxable BOOLEAN,
    price NUMERIC(15,2)
);

CREATE TABLE Purchases (
    Purchase_id SERIAL PRIMARY KEY,
    date DATE,
    time TIME,
    last_four_digits INT
);

-- Middle table for Purchases <-> Items
CREATE TABLE PurchasesItems (
    Purchase_id INT REFERENCES Purchases(Purchase_id) ON DELETE CASCADE,
    Item_id INT REFERENCES Items(Item_id) ON DELETE CASCADE,can
    quantity NUMERIC(15,4),
    PRIMARY KEY (Purchase_id, Item_id)
);
