class Item:
    def __init__(self, item_id: int, name: str, brand: str, quantity: float, unit: str,
                 per_unit_applicable: bool, is_taxable: bool, price: float):
        self.item_id = item_id
        self.name = name
        self.brand = brand
        self.quantity = quantity
        self.unit = unit
        self.per_unit_applicable = per_unit_applicable
        self.is_taxable = is_taxable
        self.price = price