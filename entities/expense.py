class Expense:
    def __init__(
        self,
        expense_id: int,
        name: str,
        currency: str,
        is_taxable: bool,
        description: str,
        yearly_charges: float,
        monthly_charges: float,
        biweekly_charges: float
    ):
        self.expense_id = expense_id
        self.name = name
        self.currency = currency
        self.is_taxable = is_taxable
        self.description = description
        self.yearly_charges = yearly_charges
        self.monthly_charges = monthly_charges
        self.biweekly_charges = biweekly_charges