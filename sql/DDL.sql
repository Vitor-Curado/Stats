DROP VIEW IF EXISTS PortfolioSummary;
DROP VIEW IF EXISTS ExpenseSummary;
DROP TABLE IF EXISTS Holdings; 
DROP TABLE IF EXISTS Assets;
DROP TABLE IF EXISTS Accounts;
DROP TABLE IF EXISTS PurchasesItems;
DROP TABLE IF EXISTS Purchases;
DROP TABLE IF EXISTS Items;
DROP TABLE IF EXISTS Stores;
DROP TABLE IF EXISTS Expenses;

-- Table Accounts
CREATE TABLE Accounts (
    Account_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    type VARCHAR(100),
    cash_balance NUMERIC(15,2),
    contribution_limit NUMERIC(15,2)
);

-- Table Assets
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

-- Table Holdings (middle table for Accounts <-> Assets)
CREATE TABLE Holdings (
    Account_id INT REFERENCES Accounts(Account_id) ON DELETE CASCADE,
    Asset_id INT REFERENCES Assets(Asset_id) ON DELETE CASCADE,
    shares NUMERIC(15,4),
    average_purchase_price NUMERIC(15,4),
    PRIMARY KEY (Account_id, Asset_id)
);

-- Table Expenses
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

-- Table Stores
CREATE TABLE Stores (
    Store_id SERIAL PRIMARY KEY,
    brand VARCHAR(100),
    street_number INT,
    street_name VARCHAR(255),
    postal_code VARCHAR(20)
);

-- Table Items
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

-- Table Purchases
CREATE TABLE Purchases (
    Purchase_id SERIAL PRIMARY KEY,
    currency VARCHAR(10),
    date DATE,
    time TIME,
    last_four_digits INT
);

-- Table PurchasesItems (middle table for Purchases <-> Items)
CREATE TABLE PurchasesItems (
    Purchase_id INT REFERENCES Purchases(Purchase_id) ON DELETE CASCADE,
    Item_id INT REFERENCES Items(Item_id) ON DELETE CASCADE,
    quantity NUMERIC(15,4),
    PRIMARY KEY (Purchase_id, Item_id)
);

CREATE VIEW PortfolioSummary AS
SELECT
    ac.title,
    a.ticker,
    h.shares,
    a.current_price,
    (h.shares * a.current_price) AS total,
    (h.shares * a.current_price) - (h.shares * h.average_purchase_price) AS "Unrealised capital gains",
    (h.shares * a.current_price * a.dividend_yield * 0.01) AS "Yearly dividends",
    (h.shares * a.current_price * a.mer * 0.01) AS "Yearly management costs"
FROM Holdings h
JOIN Assets a ON h.Asset_id = a.Asset_id
JOIN Accounts ac ON h.Account_id = ac.Account_id;

CREATE VIEW ExpenseSummary AS
SELECT
    e.Expense_id,
    e.name,
    e.currency,
    e.is_taxable,
    e.description,
    e.yearly_charges,
    e.monthly_charges,
    e.biweekly_charges,
    (e.yearly_charges + (e.monthly_charges * 12) + (e.biweekly_charges * 26)) AS subtotal,
    CASE
        WHEN e.currency = 'CAD' THEN (e.yearly_charges + (e.monthly_charges * 12) + (e.biweekly_charges * 26))
        ELSE (e.yearly_charges + (e.monthly_charges * 12) + (e.biweekly_charges * 26)) * 1.35 -- ex: conversion CAD/USD
    END AS conversion,
    CASE
        WHEN e.is_taxable = TRUE THEN
            CASE
                WHEN e.currency = 'CAD' THEN (e.yearly_charges + (e.monthly_charges * 12) + (e.biweekly_charges * 26)) * 1.15
                ELSE (e.yearly_charges + (e.monthly_charges * 12) + (e.biweekly_charges * 26)) * 1.35 * 1.15
            END
        ELSE
            CASE
                WHEN e.currency = 'CAD' THEN (e.yearly_charges + (e.monthly_charges * 12) + (e.biweekly_charges * 26))
                ELSE (e.yearly_charges + (e.monthly_charges * 12) + (e.biweekly_charges * 26)) * 1.35
            END
    END AS net
FROM Expenses e;

