DROP VIEW IF EXISTS PortfolioSummary;
DROP VIEW IF EXISTS ExpenseSummary;

CREATE OR REPLACE VIEW PortfolioSummary AS
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

CREATE OR REPLACE VIEW ExpenseSummary AS
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
