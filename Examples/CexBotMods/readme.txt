Note for CexControl.py :-: ou will still need to clone the source files of the python written cex bot from.the bellow link
git clone https://github.com/Eloque/CexControl
~ then replace the original CexControl.py with this one and it should do what it use to but with LTC instead of NMC; arberage included!

I'll be testing and updating with results on the following BitBiz forum link and here on github
http://bitbiz.io/threads/mining-operation.401/
http://bitbiz.io/threads/guide-make-coins-make-coins-with-cloud-hashing-and-trading.357/


Mod notes for CexControl.py
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


Mod notes for newFetures.py
_______________________________________________________________________________________________
# line 60 added DRK line 				## works
self.DRK = Coin("DRK", 0.10000, 0.00)

# LINE 139-147 added DRK options 		## works
try:
    self.DRK.Threshold = float(LoadedFromFile['DRKThreshold'])
except:
    log.Output ("DRK Threshold Setting not present, using default")

try:
    self.DRK.Reserve = float(LoadedFromFile['DRKReserve'])
except:
    log.Output ("DRK Reserve Setting not present, using default")

# line 187-188 added DRK options 		## works
"DRKThreshold"           :str(self.DRK.Threshold),
"DRKReserve"             :str(self.DRK.Reserve),

# line 221-222 added DRK options 		## works
self.DRK.Threshold = raw_input("Threshold to trade DRK: ")
self.DRK.Reserve   = raw_input("Reserve for DRK: ")

# line 273-274 added DRK options 		## works
log.Output ("DRK Threshold: %0.8f" % settings.DRK.Threshold)
log.Output ("DRK Reserve  : %0.8f" % settings.DRK.Reserve)

# line 355 added DRK option 			## works
PrintBalance( context, "DRK")

# Line 360-361 Corrected nmc/ltc edits from privios mod 		## seems ok
## Trade in NMC
ReinvestCoinByClass(context, settings.NMC, "BTC")
____
# line 363-371 added arbitration for DRK between BTC and LTC before trading for GHS 		## popping weird caculations?
    ## Trade in DRK for BTC or LTC then GHS
    ## Trade for BTC
    if (TargetCoin[0] == "BTC"):
        if ( arbitrate ):
            ## We will assume that on arbitrate, we also respect the Reserve
            ReinvestCoinByClass(context, settings.DRK , TargetCoin[0] )

        else:
            if ( settings.HoldCoins == True ):
                ReinvestCoinByClass(context, settings.DRK , "LTC")

    ## Trade for LTC
    if (TargetCoin[0] == "LTC"):
        if ( arbitrate ):
            ## We will assume that on arbitrate, we also respect the Reserve
            ReinvestCoinByClass(context, settings.DRK, TargetCoin[0] )
        else:
            if ( settings.HoldCoins == True ):
                ReinvestCoinByClass(context, settings.DRK, "BTC" )
____
# line 461-477 added cancel order options for DRK 		## seems ok
    ## DRK Order cancel
    order = context.current_orders("DRK/LTC")
    for item in order:
        try:
            context.cancel_order(item['id'])
            log.Output ("DRK/LTC Order %s canceled" % item['id'])
        except:
            log.Output ("Cancel order failed")

    ## DRK Order cancel
    order = context.current_orders("DRK/BTC")
    for item in order:
        try:
            context.cancel_order(item['id'])
            log.Output ("BTC/DRK Order %s canceled" % item['id'])
        except:
            log.Output ("Cancel order failed")
____ ## popping odd calculations...

# line 709-710 added DRK options for BTC/LTC 		# does what it should
    DRK_LTCPrice = GetPrice(Context, "LTC/DRK")
    DRK_BTCPrice = GetPrice(Context, "BTC/DRK")
    
# line 717-718 added DRK options 		## looks good
    DRK_LTCPrice = 1/DRK_LTCPrice
    DRK_BTCPrice = 1/DRK_BTCPrice

# line 720-721 added DRK price logging 	## looks good
    log.Output ("1 LTC is %s DRK" % FormatFloat(DRK_LTCPrice))
    log.Output ("1 BTC is %s DRK" % FormatFloat(DRK_BTCPrice))

# line 728-729 added DRK calculations for buying GHS via BTC  or LTC
    DRKviaBTC = DRK_BTCPrice * GHS_BTCPrice
    DRKviaLTC = DRK_LTCPrice * GHS_LTCPrice

# line 734-735 added DRK price caculations
    DRKviaBTCPercentage = DRKviaBTC / DRK_BTCPrice * 100
    DRKviaLTCPercentage = DRKviaLTC / DRK_LTCPrice * 100

# line 741-744 added DRK logging for buying GHS with LTC or BTC
    log.Output ("1 BTC via DRK is %s GHS" % FormatFloat(DRKviaBTC) )
    log.Output ("Efficiency : %2.2f" % DRKviaBTCPercentage)
    log.Output ("1 LTC via DRK is %s GHS" % FormatFloat(DRKviaLTC) )
    log.Output ("Efficiency : %2.2f" % DRKviaLTCPercentage)

# line 750-755 added DRK caculations
    if DRKviaBTCPercentage > DRKviaLTCPercentage:
        coin = "BTC"
        efficiency = DRKviaBTCPercentage - 100
    else:
        coin = "LTC"
        efficiency = DRKviaLTCPercentage - 100
_____

# line 784-788 added DRK ticker options
    if CoinName == "DRK" :
        if TargetCoin == "LTC" :
            Ticker = "LTC/DRK"
        if TargetCoin == "BTC" :
            Ticker = "BTC/DRK"
            
~~~~~~~ ## sample output start
1 LTC is 1.79244202 DRK
1 BTC is 170.70089789 DRK
1 LTC is 2.75634338 GHS
1 LTC is 0.01063550 BTC
1 BTC is 261.04207998 GHS
1 BTC is 94.02472850 LTC

1 BTC via DRK is 44560.11743937 GHS
Efficiency : 26104.21
1 LTC via DRK is 4.94058571 GHS
Efficiency : 275.63
1 BTC via LTC is 259.16443794 GHS
Efficiency : 99.28
1 LTC via BTC is 2.77631304 GHS
Efficiency : 100.72
~~~~~~~ ## sample output end
~~~~~~~ ## notes start

__ code sample start
    DRK_LTCPrice = GetPrice(Context, "LTC/DRK")
    DRK_BTCPrice = GetPrice(Context, "BTC/DRK")
    DRK_LTCPrice = 1/DRK_LTCPrice 					## 
    DRK_BTCPrice = 1/DRK_BTCPrice 					## 
__ code sample end
~	>	the first set of variable assignment seems to make a network call and the second temperaroly saves this data for a round such that it only makes one netwok request per pare.
	>	if true then this is a clever way to avoid a IP ban from cex for making to many API calls to close togeather.
__ code sample start
    DRKviaBTC = DRK_BTCPrice * GHS_BTCPrice 		## 
    DRKviaLTC = DRK_LTCPrice * GHS_LTCPrice 		## 
    LTCviaBTC = LTC_BTCPrice * GHS_BTCPrice 		## 
    BTCviaLTC = BTC_LTCPrice * GHS_LTCPrice 		## 
__ code sample end
~	>	These variables store exchange data

~~~~~~~ ## notes end
_______________________________________________________________________________________________


    ## Trade for BTC
    if (TargetCoin[0] == "BTC"):
        if ( arbitrate ):
            ## We will assume that on arbitrate, we also respect the Reserve
            ReinvestCoinByClass(context, settings.LTC , TargetCoin[0] )

        else:
            if ( settings.HoldCoins == False ):
                ReinvestCoinByClass(context, settings.LTC , "GHS")

        ReinvestCoinByClass(context, settings.BTC, "GHS" )

    ## Trade for LTC
    if (TargetCoin[0] == "LTC"):
        if ( arbitrate ):
            ## We will assume that on arbitrate, we also respect the Reserve
            ReinvestCoinByClass(context, settings.BTC, TargetCoin[0] )
        else:
            if ( settings.HoldCoins == False ):
                ReinvestCoinByClass(context, settings.BTC, "GHS" )

        ReinvestCoinByClass(context, settings.LTC, "GHS" )


_________

    ## Trade in DRK for BTC or LTC then GHS
    ## Trade for BTC
    if (TargetCoin[0] == "BTC"):
        if ( arbitrate ):
            ## We will assume that on arbitrate, we also respect the Reserve
            ReinvestCoinByClass(context, settings.DRK , TargetCoin[0] )

        else:
            if ( settings.HoldCoins == False ):
                ReinvestCoinByClass(context, settings.DRK , "LTC")

    ## Trade for LTC
    if (TargetCoin[0] == "LTC"):
        if ( arbitrate ):
            ## We will assume that on arbitrate, we also respect the Reserve
            ReinvestCoinByClass(context, settings.DRK, TargetCoin[0] )
        else:
            if ( settings.HoldCoins == False ):
                ReinvestCoinByClass(context, settings.DRK, "BTC" )





_________________________________________________
## Get TargetCoin, reveal what coin we should use to buy GHS
def GetTargetCoin(Context):
    ## Get the Price LTC/BTC

    GHS_LTCPrice = GetPrice(Context, "GHS/LTC")
    GHS_BTCPrice = GetPrice(Context, "GHS/BTC")
    LTC_BTCPrice = GetPrice(Context, "LTC/BTC")
    # DRK_BTCPrice = GetPrice(Context, "DRK/BTC")
    # DRK_LTCPrice = GetPrice(Context, "DRK/LTC")

    BTC_LTCPrice = 1/LTC_BTCPrice

    GHS_LTCPrice = 1/GHS_LTCPrice
    GHS_BTCPrice = 1/GHS_BTCPrice
    # BTC_DRKPrice = 1/DRK_BTCPrice
    # LTC_DRKPrice = 1/DRK_LTCPrice

    log.Output ("1 LTC is %s GHS" % FormatFloat(GHS_LTCPrice))
    log.Output ("1 LTC is %s BTC" % FormatFloat(LTC_BTCPrice))
    log.Output ("1 BTC is %s GHS" % FormatFloat(GHS_BTCPrice))
    log.Output ("1 BTC is %s LTC" % FormatFloat(BTC_LTCPrice))
    # log.Output ("1 BTC is %s DRK" % FormatFloat(BTC_DRKPrice))
    # log.Output ("1 DRK is %s BTC" % FormatFloat(DRK_BTCPrice))
    # log.Output ("1 LTC is %s DRK" % FormatFloat(LTC_DRKPrice))
    # log.Output ("1 DRK is %s LTC" % FormatFloat(DRK_LTCPrice))

    LTCviaBTC = LTC_BTCPrice * GHS_BTCPrice
    BTCviaLTC = BTC_LTCPrice * GHS_LTCPrice
    # DRKviaBTC = DRK_BTCPrice * GHS_BTCPrice
    # DRKviaLTC = DRK_LTCPrice * GHS_LTCPrice

    BTCviaLTCPercentage = BTCviaLTC / GHS_BTCPrice * 100
    LTCviaBTCPercentage = LTCviaBTC / GHS_LTCPrice * 100
    # DRKviaBTCPercentage = DRKviaBTC / GHS_BTCPrice * 100
    # DRKviaLTCPercentage = DRKviaBTC / GHS_LTCPrice * 100

    log.Output ("")
    log.Output ("1 BTC via LTC is %s GHS" % FormatFloat(BTCviaLTC) )
    log.Output ("Efficiency : %2.2f" % BTCviaLTCPercentage)
    log.Output ("1 LTC via BTC is %s GHS" % FormatFloat(LTCviaBTC) )
    log.Output ("Efficiency : %2.2f" % LTCviaBTCPercentage)
    # log.Output ("1 DRK via BTC is %s GHS" % FormatFloat(DRKviaBTC) )
    # log.Output ("Efficiency : %2.2f" % DRKviaBTCPercentage)
    # log.Output ("1 DRK via LTC is %s GHS" % FormatFloat(DRKviaLTC) )
    # log.Output ("Efficiency : %2.2f" % DRKviaLTCPercentage)

    if LTCviaBTCPercentage > BTCviaLTCPercentage:
        coin = "BTC"
        efficiency = LTCviaBTCPercentage - 100
    else:
        coin = "LTC"
        efficiency = BTCviaLTCPercentage - 100
    # if DRKviaBTCPercentage > DRKviaLTCPercentage:
    #     coin = "BTC"
    #     efficiency = DRKviaBTCPercentage - 100
    # else:
    #     coin = "LTC"
    #     efficiency = DRKviaLTCPercentage - 100

_________________________________________________
