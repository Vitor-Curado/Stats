from datetime import date, time

class Purchase:
    def __init__(self, purchase_id: int, date_: date, time_: time, last_four_digits: int):
        self.purchase_id = purchase_id
        self.date = date_
        self.time = time_
        self.last_four_digits = last_four_digits