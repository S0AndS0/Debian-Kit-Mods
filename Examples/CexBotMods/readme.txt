Note for CexControl.py :-: ou will still need to clone the source files of the python written cex bot from.the bellow link
git clone https://github.com/Eloque/CexControl
~ then replace the original CexControl.py with this one and it should do what it use to but with LTC instead of NMC; arberage included!

I'll be testing and updating with results on the following BitBiz forum link and here on github
http://bitbiz.io/threads/mining-operation.401/
http://bitbiz.io/threads/guide-make-coins-make-coins-with-cloud-hashing-and-trading.357/



_______________________________________________________________________________________________
# Line 343 settings.NMC changed to settings.LTC
ReinvestCoinByClass(context, settings.NMC, TargetCoin[0] )

# line 347 settings.NMC changed to settings.LTC
ReinvestCoinByClass(context, settings.NMC, "GHS")

# line 351-2 NMC changed to LTC
## Trade for NMC
if (TargetCoin[0] == "NMC"):

# line 360 settings.NMC changed to settings.LTC
ReinvestCoinByClass(context, settings.NMC, "GHS" )

# line 399-400 NMC changed to LTC and GHS/NMC changed to GHS/LTC
## NMC Order cancel
order = context.current_orders("GHS/NMC")

# line 404 GHS/NMC changed to GHS/LTC
log.Output ("GHS/NMC Order %s canceled" % item['id'])

# line 408-9 NMC changed to LTC and NMC/BTC changed to LTC/BTC
## NMC Order cancel
order = context.current_orders("NMC/BTC")

# line 413 BTC/NMC changed to BTC/LTC
log.Output ("BTC/NMC Order %s canceled" % item['id'])

# line 643 GHS/NMC changed to GHS/LTC variable names changed too
GHS_NMCPrice = GetPrice(Context, "GHS/NMC")

# line 645 NMC/BTC changed to LTC/BTC variable names changed too
NMC_BTCPrice = GetPrice(Context, "NMC/BTC")

# line 647-9 variable names changed
BTC_NMCPrice = 1/NMC_BTCPrice

GHS_NMCPrice = 1/GHS_NMCPrice

# line 652-3 NMC changed to LTC variable names changed too
log.Output ("1 NMC is %s GHS" % FormatFloat(GHS_NMCPrice))
log.Output ("1 NMC is %s BTC" % FormatFloat(NMC_BTCPrice))

# line 655 NMC changed to LTC variable names changed too
log.Output ("1 BTC is %s NMC" % FormatFloat(BTC_NMCPrice))

# LINE 657-661 variable names changed
NMCviaBTC = NMC_BTCPrice * GHS_BTCPrice
BTCviaNMC = BTC_NMCPrice * GHS_NMCPrice

BTCviaNMCPercentage = BTCviaNMC / GHS_BTCPrice * 100
NMCviaBTCPercentage = NMCviaBTC / GHS_NMCPrice * 100

# line 664-7 NMC changed to LTC
log.Output ("1 BTC via LTC is %s GHS" % FormatFloat(BTCviaNMC) )
log.Output ("Efficiency : %2.2f" % BTCviaNMCPercentage)
log.Output ("1 NMC via BTC is %s GHS" % FormatFloat(NMCviaBTC) )
log.Output ("Efficiency : %2.2f" % NMCviaBTCPercentage)

# line 669-674 NMC changed to LTC variable names changed too
if NMCviaBTCPercentage > BTCviaNMCPercentage:
        coin = "BTC"
        efficiency = NMCviaBTCPercentage - 100
    else:
        coin = "NMC"
        efficiency = BTCviaNMCPercentage - 100
# line 696-706
if CoinName == "NMC" :
        if TargetCoin == "GHS" :
            Ticker = "GHS/NMC"
        if TargetCoin == "BTC" :
            Ticker = "NMC/BTC"

    if CoinName == "BTC" :
        if TargetCoin == "GHS" :
            Ticker = "GHS/BTC"
        if TargetCoin == "NMC" :
            Ticker = "NMC/BTC"

# line 711-2 changed LTC to NMC

    if CoinName == "LTC" :
        Ticker = "LTC/BTC"

_______________________________________________________________________________________________