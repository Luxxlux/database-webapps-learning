SELECT *
FROM portfolio;


SELECT date,price
FROM stockprice
WHERE symbol='AAPL';

SELECT name, state, market
FROM stock
WHERE state='CA'
ORDER BY market ASC;

SELECT symbol, numShares
FROM portfolio
WHERE sell_date IS NULL;