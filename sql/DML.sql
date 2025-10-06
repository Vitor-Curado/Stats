INSERT INTO Assets (ticker, title, mer, dividend_yield, current_price)
VALUES 
	('VFV', 'Vanguard S&P 500 Index ETF', 0.08, 0.94, 162.02), 
	('VCN', 'Vanguard FTSE Can All Capital Index ETF', 0.06, 2.35, 60.02),
	('VIU', 'Vanguard Investments Canada Inc. - FTSE Developed All Capital Ex North America Index ETF', 0.23, 2.26, 41.27),
	('MNT', 'Canadian Gold Reserves Exchange-Traded Receipts', 0.35, 0.00, 53.75),
	('MNS', 'Royal Canadian Mint - Canadian Silver Reserves Exchange Traded Receipts', 0.45, 0.00, 35.31),
	('TCSH', 'TD Cash Management ETF - CAD', 0.15, 3.55, 50.07);

INSERT INTO Accounts (title, type)
VALUES 
    ('TFSA', 'Tax-Free Savings Account'),
    ('RRSP', 'Registered Retirement Savings Plan');

INSERT INTO Holdings (account_id, asset_id, shares, average_purchase_price)
VALUES
	(1, 1, 57, 149.06),
	(1, 2, 57, 56.88),
	(1, 3, 57, 39.11),
	(1, 4, 57, 51.85),
	(1, 5, 57, 31.21),
	(2, 1, 1, 146.60),
	(2, 2, 1, 57.04),
	(2, 3, 1, 38.79),
	(2, 4, 1, 50.49),
	(2, 5, 1, 30.49);

INSERT INTO Expenses (name, currency, is_taxable, description, yearly_charges, monthly_charges, biweekly_charges)
VALUES 
	('TryHackMe', 'USD', 'Yes', 'Cybersecurity training', 142.38, 0.0, 0.0),
	('Fit4Less', 'CAD', 'Yes', 'Cheap gym subscription', 49.99, 0.0, 7.99),
	('Costco', 'CAD', 'Yes', 'Grocery subscription', 130.00, 0.0, 0.0),
	('Phone', 'CAD', 'Yes', 'Phone plan', 0.0, 26.0, 0.0),
	('Duolingo', 'CAD', 'Yes', 'Language learning application', 0.0, 19.99, 0.0),
	('Rent', 'CAD', 'No', 'Roof over my head', 0.0, 879.75, 0.0),
	('Management expenses', 'CAD', 'No', 'Fees of AUM', 35.02, 0.0, 0.0);
