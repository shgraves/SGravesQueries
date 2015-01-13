SELECT DISTINCT CONVERT(DATE,date_entered,101) AS reportDate  
		, processor
		, domesticIntl
		, reportRegion1
		, reportRegion2
		, Country
		, gatewayActionType
		, payment_type
		, a.response_code  
		, a.reason_code 
		, error_description
        , order_id
		, payment
		, source
		, privatelabelid
		, TransactionCurrencyType
		, SUM(transactionCurrencyTotal) AS TranTotal
		, Count(Distinct cpl_id) as Transactions
	 FROM godaddyCPL.dbo.gdshop_common_purchase_log a (NOLOCK)  
		JOIN godaddyCPL.dbo.commonResponseReason rr on a.response_Code = rr.response_code and a.reason_Code = rr.Reason_Code  
		LEFT JOIN gdAnalyticDW.dbo.rptDimCountry dc on a.billing_country_code = dc.countrycode
	WHERE a.date_entered >= DATEADD(mm, DATEDIFF(m, 0, GETDATE()) - 15, 0) 
        AND a.date_entered < convert(DATE,GETDATE())
	    AND Processor <> '1'
GROUP BY CONVERT(DATE,date_entered,101) 
		, processor
		, domesticIntl
		, reportRegion1
		, reportRegion2
		, Country
		, gatewayActionType
		, payment_type
		, a.response_code  
		, a.reason_code 
		, error_description
        , order_id
		, payment
		, source
		, privatelabelid
		, TransactionCurrencyType