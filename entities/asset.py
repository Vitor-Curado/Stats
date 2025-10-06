from datetime import datetime

class Asset:
    def __init__(
        self,
        asset_id: int,
        ticker: str,
        title: str,
        type: str,
        MER: float,
        dividend_yield: float,
        number_of_holdings: int,
        price_to_earnings: float,
        currency: str,
        exchange: str,
        current_price: str,
        last_updated_on: datetime
    ):
        self.asset_id = asset_id
        self.ticker = ticker
        self.title = title
        self.type = type
        self.MER = MER
        self.dividend_yield = dividend_yield
        self.number_of_holdings = number_of_holdings
        self.price_to_earnings = price_to_earnings
        self.currency = currency
        self.exchange = exchange
        self.current_price = current_price
        self.last_updated_on = last_updated_on