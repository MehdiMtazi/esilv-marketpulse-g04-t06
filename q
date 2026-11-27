[1mdiff --git a/src/main.py b/src/main.py[m
[1mindex 884b045..9f003cc 100644[m
[1m--- a/src/main.py[m
[1m+++ b/src/main.py[m
[36m@@ -2,60 +2,59 @@[m [mfrom pathlib import Path[m
 import csv[m
 import json[m
 [m
[31m-[m
 DATA_DIR = Path("data/sample")[m
[31m-[m
[31m-# These starter values mirror config/settings.yml.[m
[31m-# settings.yml is a human-readable configuration contract in the CORE.[m
[31m-# Parsing YAML is optional and is not required by the 18-hour lab sequence.[m
 LOOKBACK_LABEL = "1 month"[m
 INTERVAL_LABEL = "Daily"[m
 [m
[31m-[m
 def load_instruments():[m
     with open(DATA_DIR / "instruments.json", encoding="utf-8") as file:[m
         return json.load(file)[m
 [m
[31m-[m
 def load_prices():[m
     with open(DATA_DIR / "prices.csv", encoding="utf-8") as file:[m
         return list(csv.DictReader(file))[m
 [m
[31m-[m
 def filter_prices(prices, ticker):[m
     return [row for row in prices if row["ticker"] == ticker][m
 [m
[32m+[m[32m# New functions for part 8[m
[32m+[m[32mdef get_first_close(prices):[m
[32m+[m[32m    if not prices:[m
[32m+[m[32m        return 0.0[m
[32m+[m[32m    return float(prices[0]["close"])[m
[32m+[m
[32m+[m[32mdef get_last_close(prices):[m
[32m+[m[32m    if not prices:[m
[32m+[m[32m        return 0.0[m
[32m+[m[32m    return float(prices[-1]["close"])[m
[32m+[m
[32m+[m[32mdef display_market_summary(asset, prices, show_currency=True):[m
[32m+[m[32m    first_close = get_first_close(prices)[m
[32m+[m[32m    last_close = get_last_close(prices)[m
[32m+[m[32m    currency_suffix = f" {asset.get('currency', '')}" if show_currency else ""[m
[32m+[m[32m    print(f"{asset['ticker']} - {asset['name']}")[m
[32m+[m[32m    print(f"Observations : {len(prices)}")[m
[32m+[m[32m    print(f"First close : {first_close:.2f}{currency_suffix}")[m
[32m+[m[32m    print(f"Last close : {last_close:.2f}{currency_suffix}")[m
 [m
 def main():[m
     instruments = load_instruments()[m
     prices = load_prices()[m
[31m-[m
     instrument = instruments["instrument"][m
     benchmark = instruments["benchmark"][m
[31m-[m
     instrument_prices = filter_prices(prices, instrument["ticker"])[m
     benchmark_prices = filter_prices(prices, benchmark["ticker"])[m
[31m-[m
[31m-    instrument_latest = instrument_prices[-1][m
[31m-    benchmark_latest = benchmark_prices[-1][m
[31m-[m
     print("=== MarketPulse ===")[m
     print()[m
[32m+[m[32m    print("Market configuration")[m
[32m+[m[32m    print(f"Period : {LOOKBACK_LABEL}")[m
[32m+[m[32m    print(f"Interval : {INTERVAL_LABEL}")[m
[32m+[m[32m    print()[m
     print("Instrument")[m
[31m-    print(f"{instrument['ticker']} - {instrument['name']}")[m
[31m-    print(f"Last price: {instrument_latest['close']} {instrument['currency']}")[m
[32m+[m[32m    display_market_summary(instrument, instrument_prices, show_currency=True)[m
     print()[m
     print("Benchmark")[m
[31m-    print(f"{benchmark['ticker']} - {benchmark['name']}")[m
[31m-    print(f"Last level: {benchmark_latest['close']}")[m
[31m-    print()[m
[31m-    print(f"Period: {LOOKBACK_LABEL}")[m
[31m-    print(f"Interval: {INTERVAL_LABEL}")[m
[31m-    print()[m
[31m-    print("Observations")[m
[31m-    print(f"{instrument['ticker']}: {len(instrument_prices)}")[m
[31m-    print(f"{benchmark['ticker']}: {len(benchmark_prices)}")[m
[31m-[m
[32m+[m[32m    display_market_summary(benchmark, benchmark_prices, show_currency=False)[m
 [m
 if __name__ == "__main__":[m
[31m-    main()[m
[32m+[m[32m    main()[m
\ No newline at end of file[m
