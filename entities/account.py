class Account:
    def __init__(self, account_id: int, title: str, type: str, cash_balance: float, contribution_limit: float):
        self.account_id = account_id
        self.title = title
        self.type = type
        self.cash_balance = cash_balance
        self.contribution_limit = contribution_limit