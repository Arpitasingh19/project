SELECT
UnifiedssotIndividualTun1__dlm.ssot__Id__c as UnifiedIndividualID__c,
SUM(CASE WHEN UnifiedLink.PlatinumPeriodTotalAmount > 0 THEN UnifiedLink.PlatinumPeriodTotalAmount ELSE 0 END) as PlatinumPeriodTotalAmount__c,
SUM(CASE WHEN UnifiedLink.PlatinumPriorPeriodTotalAmount > 0 THEN UnifiedLink.PlatinumPriorPeriodTotalAmount ELSE 0 END) as PlatinumPriorPeriodTotalAmount__c,
SUM(DISTINCT(CASE WHEN UnifiedLink.PlatinumPeriodTotalAmount >0 THEN UnifiedLink.PlatinumPeriodTotalAmount ELSE 0 END)) + SUM(DISTINCT(CASE WHEN UnifiedLink.PlatinumPriorPeriodTotalAmount >0 THEN UnifiedLink.PlatinumPriorPeriodTotalAmount ELSE 0 END)) as PlatinumTotalProgram__c,
SUM(CASE WHEN UnifiedLink.Perf365DaysTotalAmount >0 THEN UnifiedLink.Perf365DaysTotalAmount ELSE 0 END) as Perf365DaysTotalAmount__c,
SUM(CASE WHEN UnifiedLink.PerfMTDTotalAmount > 0 THEN UnifiedLink.PerfMTDTotalAmount ELSE 0 END) as PerfMTDTotalAmount__c,
SUM(CASE WHEN UnifiedLink.PriorMonthTotalAmount > 0 THEN UnifiedLink.PriorMonthTotalAmount ELSE 0 END) as PriorMonthTotalAmount__c,
SUM(CASE WHEN UnifiedLink.PriorYearMonthTotalAmount > 0 THEN UnifiedLink.PriorYearMonthTotalAmount ELSE 0 END) as PriorYearMonthTotalAmount__c,
SUM(CASE WHEN UnifiedLink.LifetimeTotalAmount > 0 THEN UnifiedLink.LifetimeTotalAmount ELSE 0 END) as LifetimeTotalAmount__c,
SUM(CASE WHEN UnifiedLink.LifeTimeCountOrders > 0 THEN UnifiedLink.LifeTimeCountOrders ELSE 0 END) as LifeTimeCountOrders__c,
SUM(CASE WHEN UnifiedLink.LifetimeTotalAmount > 0 THEN UnifiedLink.LifetimeTotalAmount ELSE 0 END) + SUM(CASE WHEN UnifiedLink.LifetimeWithGCAmount > 0 THEN UnifiedLink.LifetimeWithGCAmount ELSE 0 END) as LifetimeWithGCAmount__c,
SUM(CASE WHEN UnifiedLink.Last12MonthsTotalAmount > 0 THEN UnifiedLink.Last12MonthsTotalAmount ELSE 0 END) as Last12MonthsTotalAmount__c,
SUM(CASE WHEN UnifiedLink.LegacyLifetimeTotalAmount > 0 THEN UnifiedLink.LegacyLifetimeTotalAmount ELSE 0 END) as LegacyLifetimeTotalAmount__c,
SUM(CASE WHEN UnifiedLink.LegacyLifeTimeCountOrders > 0 THEN UnifiedLink.LegacyLifeTimeCountOrders ELSE 0 END) as LegacyLifeTimeCountOrders__c,
SUM(CASE WHEN UnifiedLink.LegacyLifetimeWithGCAmount > 0 THEN UnifiedLink.LegacyLifetimeWithGCAmount ELSE 0 END) as LegacyLifetimeWithGCAmount__c,

SUM(CASE WHEN UnifiedLink.PlatinumPriorPeriodTotalAmount > 0 THEN UnifiedLink.LYTYAmnt*100 ELSE 100 END) as LYTYPerAmt__c,

UnifiedLink.IndividualId AS IndividualId__c,

SUM(CASE WHEN UnifiedLink.ThirtySixMonthsTotalAmount > 0 THEN UnifiedLink.ThirtySixMonthsTotalAmount ELSE 0 END) as ThirtySixMonthsTotalAmount__c,
SUM(CASE WHEN UnifiedLink.SixtyMonthTotalAmount > 0 THEN UnifiedLink.SixtyMonthTotalAmount ELSE 0 END) as SixtyMonthTotalAmount__c,
SUM(CASE WHEN UnifiedLink.TwentyFourMonthsTotalAmount > 0 THEN UnifiedLink.TwentyFourMonthsTotalAmount ELSE 0 END) as TwentyFourMonthsTotalAmount__c,
SUM(CASE WHEN UnifiedLink.lastNintyDaysTotalAmount > 0 THEN UnifiedLink.lastNintyDaysTotalAmount ELSE 0 END) as lastNintyDaysTotalAmount__c,
SUM(CASE WHEN UnifiedLink.GCCTotalAmount > 0 THEN UnifiedLink.GCCTotalAmount ELSE 0 END) as GCCTotalAmount__c,

 SUM(DISTINCT(CASE WHEN ISNULL(AccountLegacyLifetimeAmount.Legacy_Lifetime) THEN 0  ELSE AccountLegacyLifetimeAmount.Legacy_Lifetime END))
+ SUM(DISTINCT(CASE WHEN ISNULL(UnifiedLink.LifetimeTotalAmount) THEN 0 ELSE UnifiedLink.LifetimeTotalAmount END))
as LFTPlusLGTotalAmount__c,

 SUM(DISTINCT(CASE WHEN ISNULL(AccountLegacyLifetimeAmount.Legacy_Lifetime_Orders) THEN 0  ELSE AccountLegacyLifetimeAmount.Legacy_Lifetime_Orders END))
+ SUM(DISTINCT(CASE WHEN ISNULL(UnifiedLink.LifeTimeCountOrders) THEN 0 ELSE UnifiedLink.LifeTimeCountOrders END))
as LFTPlusLGCountOrders__c

FROM UnifiedssotIndividualTun1__dlm 

JOIN
(SELECT UnifiedLinkssotIndividualTun1__dlm.UnifiedRecordId__c as UnifiedIndividualID,
MAX(PlatinumPeriod.PlatinumPeriodTotalAmount) as PlatinumPeriodTotalAmount,
MAX(PlatinumPriorPeriod.PlatinumPriorPeriodTotalAmount) as PlatinumPriorPeriodTotalAmount,
MAX(Perf365Days.Perf365DaysTotalAmount) as Perf365DaysTotalAmount,
MAX(PerfMTD.PerfMTDTotalAmount) as PerfMTDTotalAmount,
MAX(PriorMonth.PriorMonthTotalAmount) as PriorMonthTotalAmount,
MAX(PriorYearMonth.PriorYearMonthTotalAmount) as PriorYearMonthTotalAmount,
MAX(Lifetime.LifetimeTotalAmount) as LifetimeTotalAmount,
MAX(LifeTimeCountOrders.LifeTimeCountOrders) as LifeTimeCountOrders,
MAX(LifetimeWithGC.LifetimeWithGCAmount) as LifetimeWithGCAmount,

(MAX(PlatinumPeriod.PlatinumPeriodTotalAmount) - MAX(PlatinumPriorPeriod.PlatinumPriorPeriodTotalAmount)) / MAX(PlatinumPriorPeriod.PlatinumPriorPeriodTotalAmount) as LYTYAmnt,

MAX(Last12Months.Last12MonthsTotalAmount) as Last12MonthsTotalAmount,
MAX(LegacyLifetime.LegacyLifetimeTotalAmount) as LegacyLifetimeTotalAmount,
MAX(LegacyLifeTimeCountOrders.LegacyLifeTimeCountOrders) as LegacyLifeTimeCountOrders,
MAX(LegacyLifetimeWithGC.LegacyLifetimeWithGCAmount) as LegacyLifetimeWithGCAmount,
UnifiedLinkssotIndividualTun1__dlm.SourceRecordId__c AS IndividualId,

MAX(ThirtySix.ThirtySixMonthsTotalAmount) as ThirtySixMonthsTotalAmount,
MAX(SixtyMonths.SixtyMonthTotalAmount) as SixtyMonthTotalAmount,
MAX(TwentyFour.TwentyFourMonthsTotalAmount) as TwentyFourMonthsTotalAmount,
MAX(lastNintyDays.lastNintyDaysTotalAmount) as lastNintyDaysTotalAmount,
MAX(GCCQuery.GCCTotalAmount) as GCCTotalAmount

FROM UnifiedLinkssotIndividualTun1__dlm

LEFT JOIN (SELECT ssot__SalesOrder__dlm.ssot__BillToContactId__c as ContactId,
SUM (CASE WHEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c >0 THEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c ELSE 0 END) - SUM (CASE WHEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c >0 THEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c ELSE 0 END) as PlatinumPeriodTotalAmount
FROM ssot__SalesOrder__dlm
WHERE (YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c)=1 AND MONTH (ssot__SalesOrder__dlm.CheckoutDate__c) >=7) OR (YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c)=0 AND ssot__SalesOrder__dlm.CheckoutDate__c <= CURRENT_DATE()) 
GROUP BY ssot__SalesOrder__dlm.ssot__BillToContactId__c) as PlatinumPeriod ON UnifiedLinkssotIndividualTun1__dlm.SourceRecordId__c = PlatinumPeriod.ContactId

LEFT JOIN (SELECT ssot__SalesOrder__dlm.ssot__BillToContactId__c as ContactId,
SUM (CASE WHEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c >0 THEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c ELSE 0 END) - SUM (CASE WHEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c >0 THEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c ELSE 0 END) as PlatinumPriorPeriodTotalAmount
FROM ssot__SalesOrder__dlm
WHERE (YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c)=2 AND MONTH (ssot__SalesOrder__dlm.CheckoutDate__c) >=7) OR (YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c)=1 AND MONTH (ssot__SalesOrder__dlm.CheckoutDate__c) <= 7)
GROUP BY ssot__SalesOrder__dlm.ssot__BillToContactId__c) as PlatinumPriorPeriod ON UnifiedLinkssotIndividualTun1__dlm.SourceRecordId__c = PlatinumPriorPeriod.ContactId

LEFT JOIN (SELECT ssot__SalesOrder__dlm.ssot__BillToContactId__c as ContactId,
SUM (CASE WHEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c >0 THEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c ELSE 0 END) - SUM (CASE WHEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c >0 THEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c ELSE 0 END) as Perf365DaysTotalAmount
FROM ssot__SalesOrder__dlm
WHERE DATEDIFF(CURRENT_DATE(), ssot__SalesOrder__dlm.CheckoutDate__c) <= 365
GROUP BY ssot__SalesOrder__dlm.ssot__BillToContactId__c) as Perf365Days ON UnifiedLinkssotIndividualTun1__dlm.SourceRecordId__c = Perf365Days.ContactId

LEFT JOIN (SELECT ssot__SalesOrder__dlm.ssot__BillToContactId__c as ContactId,
SUM (CASE WHEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c >0 THEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c ELSE 0 END) - SUM (CASE WHEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c >0 THEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c ELSE 0 END) as PerfMTDTotalAmount
FROM ssot__SalesOrder__dlm
WHERE DATEDIFF(CURRENT_DATE(), ssot__SalesOrder__dlm.CheckoutDate__c) <= 30
GROUP BY ssot__SalesOrder__dlm.ssot__BillToContactId__c) as PerfMTD
ON UnifiedLinkssotIndividualTun1__dlm.SourceRecordId__c = PerfMTD.ContactId

LEFT JOIN (SELECT ssot__SalesOrder__dlm.ssot__BillToContactId__c as ContactId,
SUM (CASE WHEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c >0 THEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c ELSE 0 END) - SUM (CASE WHEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c >0 THEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c ELSE 0 END) as PriorMonthTotalAmount
FROM ssot__SalesOrder__dlm
WHERE (YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c)=0 AND MONTH(CURRENT_DATE())- MONTH (ssot__SalesOrder__dlm.CheckoutDate__c) = 1)
GROUP BY ssot__SalesOrder__dlm.ssot__BillToContactId__c) as PriorMonth 
ON UnifiedLinkssotIndividualTun1__dlm.SourceRecordId__c = PriorMonth.ContactId

LEFT JOIN (SELECT ssot__SalesOrder__dlm.ssot__BillToContactId__c as ContactId,
SUM (CASE WHEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c >0 THEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c ELSE 0 END) - SUM (CASE WHEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c >0 THEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c ELSE 0 END) as PriorYearMonthTotalAmount
FROM ssot__SalesOrder__dlm
WHERE (YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c)=0 AND MONTH(ssot__SalesOrder__dlm.CheckoutDate__c) <= 3) OR (YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c)=1 AND MONTH (ssot__SalesOrder__dlm.CheckoutDate__c) >= 3)
GROUP BY ssot__SalesOrder__dlm.ssot__BillToContactId__c) as PriorYearMonth
ON UnifiedLinkssotIndividualTun1__dlm.SourceRecordId__c = PriorYearMonth.ContactId

LEFT JOIN (SELECT ssot__SalesOrder__dlm.ssot__BillToContactId__c as ContactId,
SUM (CASE WHEN ssot__SalesOrder__dlm.ssot__GrandTotalAmount__c >0 THEN ssot__SalesOrder__dlm.ssot__GrandTotalAmount__c ELSE 0 END) - (SUM (CASE WHEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c >0 THEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c ELSE 0 END) + SUM (CASE WHEN ssot__SalesOrder__dlm.ssot__TotalTaxAmount__c >0 THEN ssot__SalesOrder__dlm.ssot__TotalTaxAmount__c ELSE 0 END)+ SUM (CASE WHEN ssot__SalesOrder__dlm.ssot__AdjustedTotalDeliveryAmount__c >0 THEN ssot__SalesOrder__dlm.ssot__AdjustedTotalDeliveryAmount__c ELSE 0 END) + SUM (CASE WHEN ssot__SalesOrder__dlm.ssot__TotalAdjustmentAmount__c >0 THEN ssot__SalesOrder__dlm.ssot__TotalAdjustmentAmount__c ELSE 0 END)) as LifetimeTotalAmount
FROM ssot__SalesOrder__dlm
JOIN ssot__Account__dlm
ON ssot__Account__dlm.ssot__Id__c = ssot__SalesOrder__dlm.ssot__SoldToCustomerId__c
WHERE ssot__SalesOrder__dlm.CheckoutDate__c >= ssot__Account__dlm.Legacy_As_Of_Date__c
 AND (ssot__SalesOrder__dlm.CheckoutDate__c <= CURRENT_DATE())
GROUP BY ssot__SalesOrder__dlm.ssot__BillToContactId__c) as Lifetime
ON UnifiedLinkssotIndividualTun1__dlm.SourceRecordId__c = Lifetime.ContactId

LEFT JOIN (SELECT ssot__SalesOrder__dlm.ssot__BillToContactId__c as ContactId,
SUM (CASE WHEN ssot__SalesOrder__dlm.ssot__GrandTotalAmount__c >0 THEN ssot__SalesOrder__dlm.ssot__GrandTotalAmount__c ELSE 0 END) - (SUM (CASE WHEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c >0 THEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c ELSE 0 END) + SUM (CASE WHEN ssot__SalesOrder__dlm.ssot__TotalTaxAmount__c >0 THEN ssot__SalesOrder__dlm.ssot__TotalTaxAmount__c ELSE 0 END)+ SUM (CASE WHEN ssot__SalesOrder__dlm.ssot__AdjustedTotalDeliveryAmount__c >0 THEN ssot__SalesOrder__dlm.ssot__AdjustedTotalDeliveryAmount__c ELSE 0 END) + SUM (CASE WHEN ssot__SalesOrder__dlm.ssot__TotalAdjustmentAmount__c >0 THEN ssot__SalesOrder__dlm.ssot__TotalAdjustmentAmount__c ELSE 0 END)) as LegacyLifetimeTotalAmount
FROM ssot__SalesOrder__dlm
JOIN ssot__Account__dlm
ON ssot__Account__dlm.ssot__Id__c = ssot__SalesOrder__dlm.ssot__SoldToCustomerId__c
WHERE ssot__SalesOrder__dlm.CheckoutDate__c <= ssot__Account__dlm.Legacy_As_Of_Date__c
GROUP BY ssot__SalesOrder__dlm.ssot__BillToContactId__c) as LegacyLifetime
ON UnifiedLinkssotIndividualTun1__dlm.SourceRecordId__c = LegacyLifetime.ContactId

LEFT JOIN (SELECT ssot__SalesOrder__dlm.ssot__BillToContactId__c as ContactId,
COUNT (ssot__SalesOrder__dlm.ssot__BillToContactId__c) as LifeTimeCountOrders
FROM ssot__SalesOrder__dlm
JOIN ssot__Account__dlm
ON ssot__Account__dlm.ssot__Id__c = ssot__SalesOrder__dlm.ssot__SoldToCustomerId__c
WHERE ssot__SalesOrder__dlm.CheckoutDate__c >= ssot__Account__dlm.Legacy_As_Of_Date__c
AND (ssot__SalesOrder__dlm.CheckoutDate__c <= CURRENT_DATE())
GROUP BY ssot__SalesOrder__dlm.ssot__BillToContactId__c) as LifeTimeCountOrders
ON UnifiedLinkssotIndividualTun1__dlm.SourceRecordId__c = LifeTimeCountOrders.ContactId

LEFT JOIN (SELECT ssot__SalesOrder__dlm.ssot__BillToContactId__c as ContactId,
COUNT (ssot__SalesOrder__dlm.ssot__BillToContactId__c) as LegacyLifeTimeCountOrders
FROM ssot__SalesOrder__dlm
JOIN ssot__Account__dlm
ON ssot__Account__dlm.ssot__Id__c = ssot__SalesOrder__dlm.ssot__SoldToCustomerId__c
WHERE ssot__SalesOrder__dlm.CheckoutDate__c <= ssot__Account__dlm.Legacy_As_Of_Date__c
GROUP BY ssot__SalesOrder__dlm.ssot__BillToContactId__c) as LegacyLifeTimeCountOrders
ON UnifiedLinkssotIndividualTun1__dlm.SourceRecordId__c = LegacyLifeTimeCountOrders.ContactId


LEFT JOIN (SELECT ssot__SalesOrder__dlm.ssot__BillToContactId__c as ContactId,
SUM (CASE WHEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c >0 THEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c ELSE 0 END) as LifetimeWithGCAmount
FROM ssot__SalesOrder__dlm
JOIN ssot__Account__dlm
ON ssot__Account__dlm.ssot__Id__c = ssot__SalesOrder__dlm.ssot__SoldToCustomerId__c
WHERE ssot__SalesOrder__dlm.CheckoutDate__c >= ssot__Account__dlm.Legacy_As_Of_Date__c
AND (ssot__SalesOrder__dlm.CheckoutDate__c <= CURRENT_DATE())
GROUP BY ssot__SalesOrder__dlm.ssot__BillToContactId__c) as LifetimeWithGC
ON UnifiedLinkssotIndividualTun1__dlm.SourceRecordId__c = LifetimeWithGC.ContactId

LEFT JOIN (SELECT ssot__SalesOrder__dlm.ssot__BillToContactId__c as ContactId,
SUM (CASE WHEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c >0 THEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c ELSE 0 END) as LegacyLifetimeWithGCAmount
FROM ssot__SalesOrder__dlm
JOIN ssot__Account__dlm
ON ssot__Account__dlm.ssot__Id__c = ssot__SalesOrder__dlm.ssot__SoldToCustomerId__c
WHERE ssot__SalesOrder__dlm.CheckoutDate__c <= ssot__Account__dlm.Legacy_As_Of_Date__c
GROUP BY ssot__SalesOrder__dlm.ssot__BillToContactId__c) as LegacyLifetimeWithGC
ON UnifiedLinkssotIndividualTun1__dlm.SourceRecordId__c = LegacyLifetimeWithGC.ContactId


LEFT JOIN (SELECT ssot__SalesOrder__dlm.ssot__BillToContactId__c as ContactId,
SUM (CASE WHEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c >0 THEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c ELSE 0 END) - SUM (CASE WHEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c >0 THEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c ELSE 0 END) as Last12MonthsTotalAmount
FROM ssot__SalesOrder__dlm
WHERE (YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c)=0 AND MONTH(CURRENT_DATE())- MONTH (ssot__SalesOrder__dlm.CheckoutDate__c) = 1) OR (YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c)=1 AND MONTH (ssot__SalesOrder__dlm.CheckoutDate__c) >= MONTH(CURRENT_DATE())) 
GROUP BY ssot__SalesOrder__dlm.ssot__BillToContactId__c) as Last12Months
ON UnifiedLinkssotIndividualTun1__dlm.SourceRecordId__c = Last12Months.ContactId

LEFT JOIN (SELECT ssot__SalesOrder__dlm.ssot__BillToContactId__c as ContactId,
SUM (CASE WHEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c >0 THEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c ELSE 0 END) - SUM (CASE WHEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c >0 THEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c ELSE 0 END) as ThirtySixMonthsTotalAmount
FROM ssot__SalesOrder__dlm
WHERE (YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c) =3 AND MONTH (ssot__SalesOrder__dlm.CheckoutDate__c) >= MONTH(CURRENT_DATE())) OR (YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c) =2) OR (YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c) =1) OR (YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c) =0 AND MONTH (ssot__SalesOrder__dlm.CheckoutDate__c) < MONTH(CURRENT_DATE()))
 
GROUP BY ssot__SalesOrder__dlm.ssot__BillToContactId__c) as ThirtySix ON UnifiedLinkssotIndividualTun1__dlm.SourceRecordId__c = ThirtySix.ContactId

LEFT JOIN (SELECT ssot__SalesOrder__dlm.ssot__BillToContactId__c as ContactId,
SUM (CASE WHEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c >0 THEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c ELSE 0 END) - SUM (CASE WHEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c >0 THEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c ELSE 0 END) as TwentyFourMonthsTotalAmount
FROM ssot__SalesOrder__dlm
WHERE (YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c) =2 AND MONTH (ssot__SalesOrder__dlm.CheckoutDate__c) >= MONTH(CURRENT_DATE())) OR (YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c) =1) OR (YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c) =0 AND MONTH (ssot__SalesOrder__dlm.CheckoutDate__c) < MONTH(CURRENT_DATE()))
 
GROUP BY ssot__SalesOrder__dlm.ssot__BillToContactId__c) as TwentyFour ON UnifiedLinkssotIndividualTun1__dlm.SourceRecordId__c = TwentyFour.ContactId

LEFT JOIN (SELECT ssot__SalesOrder__dlm.ssot__BillToContactId__c as ContactId,
SUM (CASE WHEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c >0 THEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c ELSE 0 END) - SUM (CASE WHEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c >0 THEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c ELSE 0 END) as SixtyMonthTotalAmount
FROM ssot__SalesOrder__dlm

WHERE (YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c) =5 AND MONTH (ssot__SalesOrder__dlm.CheckoutDate__c) >= MONTH(CURRENT_DATE())) OR (YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c) =4) OR (YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c) =3) OR (YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c) =2) OR (YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c) =1) OR 

(YEAR(CURRENT_DATE()) - YEAR(ssot__SalesOrder__dlm.CheckoutDate__c) =0 AND MONTH (ssot__SalesOrder__dlm.CheckoutDate__c) < MONTH(CURRENT_DATE()))


GROUP BY ssot__SalesOrder__dlm.ssot__BillToContactId__c) as SixtyMonths ON UnifiedLinkssotIndividualTun1__dlm.SourceRecordId__c = SixtyMonths.ContactId

LEFT JOIN (SELECT ssot__SalesOrder__dlm.ssot__BillToContactId__c as ContactId,
SUM (CASE WHEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c >0 THEN ssot__SalesOrder__dlm.ssot__AdjustedTotalProductAmount__c ELSE 0 END) - SUM (CASE WHEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c >0 THEN ssot__SalesOrder__dlm.Gift_Certificate_Amount__c ELSE 0 END) as lastNintyDaysTotalAmount
FROM ssot__SalesOrder__dlm
WHERE DATEDIFF(CURRENT_DATE(),ssot__SalesOrder__dlm.CheckoutDate__c) <= 90
 
GROUP BY ssot__SalesOrder__dlm.ssot__BillToContactId__c) as lastNintyDays ON UnifiedLinkssotIndividualTun1__dlm.SourceRecordId__c = lastNintyDays.ContactId

LEFT JOIN (SELECT ssot__SalesOrder__dlm.ssot__BillToContactId__c as ContactId,
SUM (CASE WHEN ssot__SalesOrderProduct__dlm.ssot__TotalLineAmount__c >0 THEN ssot__SalesOrderProduct__dlm.ssot__TotalLineAmount__c ELSE 0 END)  as GCCTotalAmount
FROM ssot__SalesOrder__dlm
JOIN ssot__SalesOrderProduct__dlm ON ssot__SalesOrderProduct__dlm.ssot__SalesOrderId__c = ssot__SalesOrder__dlm.ssot__Id__c
WHERE ssot__SalesOrderProduct__dlm.ssot__OrderProductNumber__c = 'eGiftCertificate'
 
GROUP BY ssot__SalesOrder__dlm.ssot__BillToContactId__c) as GCCQuery ON UnifiedLinkssotIndividualTun1__dlm.SourceRecordId__c = GCCQuery.ContactId

GROUP BY UnifiedLinkssotIndividualTun1__dlm.UnifiedRecordId__c,UnifiedLinkssotIndividualTun1__dlm.SourceRecordId__c) as UnifiedLink ON UnifiedssotIndividualTun1__dlm.ssot__Id__c = UnifiedLink.UnifiedIndividualID

JOIN(
SELECT ssot__Account__dlm.ssot__Id__c as AccountID,
MAX(ssot__Account__dlm.Legacy_Lifetime__c)  as Legacy_Lifetime,
MAX(ssot__Account__dlm.Legacy_Lifetime_Orders__c) AS Legacy_Lifetime_Orders
FROM ssot__Account__dlm
GROUP BY ssot__Account__dlm.ssot__Id__c
) AS AccountLegacyLifetimeAmount
ON AccountLegacyLifetimeAmount.AccountID = UnifiedssotIndividualTun1__dlm.Account_ID__c

GROUP BY UnifiedssotIndividualTun1__dlm.ssot__Id__c,UnifiedLink.IndividualId