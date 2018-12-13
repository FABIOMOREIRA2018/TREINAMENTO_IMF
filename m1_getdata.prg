'This script downloads most of the data required for the final MFx assignment from FRED.
wfcreate(wf=mfx,page=fred) q 1945:1 2015:4
'This command downloads the required series from FRED.
fetch(c=l) fred::HNOTASQ027S HNOTFAQ027S HNOTOLQ027S CPIAUCSL A072RC1Q156SBEA RPI DPI DPIC96 PINCOME HNONWRQ027S PCEC PCDG PCESV UNRATE DPRIME PCECC96 W986RC1Q027SBEA IRLTLT01USQ156N DGS3 USSTHPI B069RC1Q027SBEA W211RC1Q027SBEA  DPCERD3Q086SBEA B703RC1Q027SBEA FYGFDPUN
'This section creates the series needed to carry out the saving ratio regression
pagecreate(page=raw) q 1945:1 2015:4
pageselect raw
genr assets = fred\HNOTASQ027S 
assets.label(d) Households and nonprofit organizations; total assets, Level 'Total wealth (nominal U.S. dollars, n.s.a)
genr assets_fin =  fred\HNOTFAQ027S 'Total financial wealth (nominal U.S. dollars, n.s.a)
assets_fin.label(d) Households and nonprofit organizations; total financial assets, Level (n.s.a)
genr assets_nonfinancial = assets - assets_fin 'Total non-financial assets (nominal, n.s.a)
assets_nonfinancial.label(d) Households and nonprofit organizations; non-financial assets, Level (n.s.a)
genr liabilities = fred\HNOTOLQ027S 'Total liabilitites (nominal, n.s.a)
liabilities.label(d) Households and nonprofit organizations; total liabilities, Level (n.s.a)
genr net_worth = fred\HNONWRQ027S 'Net worth (nominal, n.s.a)
net_worth.label(d) Households and nonprofit organizations; net worth, Level (n.s.a)
genr cpi = fred\CPIAUCSL 'Consumer price index
cpi.label(d) Consumer Price Index for All Urban Consumers: All Items 
genr saving_rate = fred\A072RC1Q156SBEA 'Saving rate, percent of disposable income
saving_rate.label(d) Personal saving as a percentage of disposable personal income
genr ny = fred\PINCOME 'Nominal income (s.a.)
ny.label(d) Personal Income
genr ndy = fred\dpi
ndy.label(d) Disposable Personal Income 'Nominal disposable income (s.a.)
genr ry = fred\rpi 'Real income (2009 dollars)
ry.label(d) Real Personal Income (2009 dollars)
genr n_piy=fred\B703RC1Q027SBEA
n_piy.label(d) Personal Interest Income
genr nly = ndy-n_piy 'Proxy for labor income.
nly.label(d) Nominal Labor Income
genr rdy =  fred\DPIC96 'Real disposable income (2009 dollars, s.a.)
rdy.label(d) Real Disposable Personal Income
genr nc = fred\PCEC 'Nominal consumption (s.a.)
nc.label(d) Personal Consumption Expenditures
genr rc = fred\PCECC96 'Real consumption (2009 dollars, s.a.)
rc.label(d) Real Personal Consumption Expenditures
genr ndc = fred\PCDG 'Nominal durable consumption
ndc.label(d) Personal Consumption Expenditures: Durable Goods
genr nsc = fred\PCESV 'Nominal services consumption
nsc.label(d) Personal Consumption Expenditures: Services
genr unemp = fred\UNRATE 'Unemployment rate
unemp.label(d) Civilian Unemployment Rate
genr prime_rate = fred\DPRIME 'Prime lending rate
prime_rate.label(d) Bank Prime Loan Rate
genr saving = fred\W986RC1Q027SBEA 'Saving (nominal, s.a.)
saving.label(d) Net private saving: Households and institutions
genr c_deflator = (fred\DPCERD3Q086SBEA)/100 'Implicit deflator (derived from nominal consumption/real consumption)
c_deflator.label(d)  Personal consumption expenditures (implicit price deflator) (2009=100)
genr y_deflator = ndy/rdy 'Income deflator (Derived from nominal disposable income / real disposable income)
y_deflator.label(d) Household Disposable Income deflator
genr r_piy = n_piy/y_deflator
r_piy.label(d) Real personal interest income
genr rly = nly/y_deflator 'real labor income (proxy)
rly.label(d) Real Labor Income
genr yield_10y = fred\IRLTLT01USQ156N '10-year treasury yield
yield_10y.label(d) Long-Term Government Bond Yields: 10-year: Main (Including Benchmark) for the United States©
genr yield_3m = fred\DGS3 '3-month treasury yield
yield_3m.label(d) 3-Year Treasury Constant Maturity Rate
genr house_prices = fred\USSTHPI 'House price index
house_prices.label(d) All-Transactions House Price Index for the United States
genr interest_payments = fred\B069RC1Q027SBEA 'Personal interest payments
interest_payments.label(d) Personal interest payments
genr gov_transfers = fred\W211RC1Q027SBEA 'Personal current transfer payments
gov_transfers.label(d) Personal current transfer payments 
genr gov_debt = FYGFDPUN
gov_debt.label(d) Federal debt held by the public
'NB: We need to download consumer_sentiment and MORTG from FRED manually because they are copyrighted series...background download is not permitted for such series.
series consumer_sentiment
consumer_sentiment.label(d) University of Michigan: Consumer Sentiment Index
series mortgage_30y
mortgage_30y.label(d) 30-Year Fixed Rate Mortgage Average in the United States
pagecreate(page=usa_cy) q 1945:1 2015:4
pageselect usa_cy
copy raw\*
smpl @all
genr rnw = net_worth/y_deflator
rnw.label(d) Real Net Worth of the Household Sector
genr sb_1975_4 = 0
sb_1975_4.label(d) Dummy variable to caputure structural break on or around 1975Q4
smpl @first 1975Q4
genr sb_1975_4 = 1
smpl @all


