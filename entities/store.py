class Store:
    def __init__(self, store_id: int, brand: str, street_number: int, street_name: str,
                 postal_code: str, city: str, province: str):
        self.store_id = store_id
        self.brand = brand
        self.street_number = street_number
        self.street_name = street_name
        self.postal_code = postal_code
        self.city = city
        self.province = province