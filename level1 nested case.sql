use dec12;
select * from customerusage;

-- Question 1: Tiered Engagement Classification
-- Classify customers into detailed engagement tiers:
-- •	If the customer is Postpaid:
-- o	If data used (GB) is greater than 25:
-- 	If call minutes are more than 1500 and monthly bill is greater than 1200, classify as 'Ultra Premium User'.
-- 	Else, if monthly bill is between 900 and 1200 inclusive, classify as 'Premium Postpaid User'.
-- 	Otherwise, classify as 'Standard High Data User'.
-- o	Else, if call minutes are greater than 1000, classify as 'Voice Heavy Postpaid'.
-- o	Otherwise, classify as 'Standard Postpaid'.
-- •	If the customer is Prepaid:
-- o	If monthly bill is greater than 1000:
-- 	If call minutes are less than 300, classify as 'Mismatch High Payer'.
-- 	Otherwise, classify as 'Top Prepaid User'.
-- o	Else, if data used (GB) is less than 10, classify as 'Basic Prepaid User'.

select *,
case
	when plan_type = 'Postpaid' then
		case
			when data_used_gb > 25 then
				case
					when call_minutes > 1500 and monthly_bill > 1200 then 'Ultra Premium User'
                    when monthly_bill between 900 and 1200 then 'Premium Postpaid User'
                    else 'Standard High Data User'
                end
			when call_minutes > 1000 then 'Voice Heavy Postpaid'
			else 'Standard Postpaid'
		end
	when plan_type = 'Prepaid' then
		case
			when monthly_bill > 1000 then
				case
					when call_minutes < 300 then 'Mismatch High Payer'
					else 'Top Prepaid User'
                end
			when data_used_gb < 10 then 'Basic Prepaid User'
			else 'Mid-Range Prepaid User'
		end
end as classification
from customerusage;

-- Question 2: Usage Optimization Suggestion Engine
-- Determine the best suggestion for plan optimization:
-- •	If plan type is Prepaid:
-- o	If monthly bill is greater than 800:
-- 	If call minutes are greater than 1000:
-- 	If data used (GB) is less than 10, suggest 'Switch to Voice Add-on'.
-- 	Else if data used (GB) is greater than 25, suggest 'Switch to Postpaid Premium Plan'.
-- 	Otherwise, suggest 'Upgrade to Postpaid Base Plan'.
-- 	Otherwise, advise 'Recharge Reduction Advised'.
-- o	Otherwise, state 'Current Plan OK'.
-- •	If plan type is Postpaid:
-- o	If data used (GB) is less than 10:
-- 	If monthly bill is greater than 700, suggest 'Switch to Lower Postpaid Plan'.
-- 	Otherwise, state 'Satisfactory Plan'.
-- o	Else if data used (GB) is greater than 25:
-- 	If call minutes are less than 500, suggest 'Consider Data-Only Plan'.
-- 	Otherwise, mark as 'Premium User Verified'.
-- o	Otherwise, state 'No Change Needed'

select *,case
when plan_type = 'Prepaid' then
			case
				when monthly_bill > 800 then
							case
								when call_minutes >1000 then 
										case
											when data_used_gb < 10 then 'Switch to Voice Add-on'
                                            when data_used_gb > 25 then 'Switch to Postpaid Premium Plan'
                                            else 'Upgrade to Postpaid Base Plan'
                                        end
                                else 'Recharge Reduction Advised'
                            end
				else 'Current Plan OK'           
            end
when plan_type = 'Postpaid' then 
			case 
				when data_used_gb < 10 then
							case
								when monthly_bill > 700 then 'Switch to Lower Postpaid Plan'
                                else 'Satisfactory Plan'
							end
                when data_used_gb > 25 then
					case
						when call_minutes < 500 then 'Consider Data-Only Plan'
                        else 'Premium User Verified'
                    end
                
                else 'No Change Needed'
            end
end  as suggest
from customerusage

-- Question 3: Loyalty Band & Risk Detection
-- Assign loyalty band and detect fraud or churn risk flags:
-- •	If monthly bill is greater than 1000:
-- o	If call minutes are less than 200:
-- 	If data used (GB) is less than 5, flag as 'High Risk – Unusual Billing'.
-- 	Otherwise, flag as 'Watch List – High Spend, Low Talk'.
-- o	Otherwise:
-- 	If data used (GB) is greater than 30, assign 'Loyal Premium Tier 1'.
-- 	Otherwise, assign 'Loyal Tier 2'.
-- •	Else if monthly bill is between 500 and 1000 inclusive:
-- o	If call minutes are greater than 1200:
-- 	If data used (GB) is less than 10, assign 'Voice Optimized – Tier 3'.
-- 	Otherwise, assign 'Balanced Loyal – Tier 4'.
-- o	Otherwise, assign 'Mid Spend Average'.
-- •	Otherwise:
-- o	If plan type is Prepaid and data used (GB) is greater than 20, assign 'Emerging Value User'.
-- o	Otherwise, assign 'Basic User'.

select *,
case
	when monthly_bill >1000 then
		case
			when call_minutes <200 then
					case
						when data_used_gb < 5 then 'High Risk – Unusual Billing'
                        else 'High Risk – Unusual Billing'
                    end
            else 
				case 
					when data_used_gb > 30 then 'Loyal Premium Tier 1'
                    else 'Loyal Tier 2'
                end
            
        end
    when monthly_bill between 500 and 1000 then
			case
				when call_minutes > 1200 then
					case 
						when data_used_gb < 10 then 'Voice Optimized – Tier 3'
                        else 'Balanced Loyal – Tier 4'
                    end
                else 'Mid Spend Average'
            end
    else
		case
			when plan_type = 'Prepaid' and data_used_gb > 20 then 'Emerging Value User'
            else 'Basic User'
        end
end 
from customerusage


-- Question 4: Customer Journey Stage Mapping
-- Identify the user journey stage:
-- •	If plan type is Postpaid:
-- o	If data used (GB) is greater than 20:
-- 	If monthly bill is greater than 1000:
-- 	If call minutes are greater than 1200, assign 'Retention - Reward Eligible'.
-- 	Otherwise, assign 'Retention - Cross Sell Data Pack'.
-- 	Otherwise, assign 'Growth - Suggest Plan Boost'.
-- o	Otherwise, assign 'Entry Level Postpaid'.
-- •	If plan type is Prepaid:
-- o	If monthly bill is greater than 900:
-- 	If data used (GB) is less than 10, assign 'Upgrade to Voice Plan'.
-- 	Otherwise, assign 'Cross Sell Postpaid'.
-- o	Else if data used (GB) is greater than 25 and call minutes are greater than 1000, assign 'Cross Sell Hybrid Plan'.
-- o	Otherwise, assign 'New Prepaid Journey'.

select *,
case
	when plan_type = 'Postpaid' then
					case
						when data_used_gb > 20 then
							case 
								when monthly_bill > 1000 then
									case 
										when call_minutes > 1200 then 'Retention - Reward Eligible'
                                        else 'Retention - Cross Sell Data Pack'
                                    end
                                else 'Growth - Suggest Plan Boost'
                            end
                        else 'Entry Level Postpaid'
                    end
    when plan_type = 'Prepaid' then
		case
			when monthly_bill > 900 then
					case
						when data_used_gb < 10 then 'Upgrade to Voice Plan'
                        else 'Cross Sell Postpaid'
                    end
            when data_used_gb > 25 and call_minutes > 1000 then 'Cross Sell Hybrid Plan' 
            else 'New Prepaid Journey' 
        end
end
from customerusage

-- Question 5: AI Smart Alert Classification
-- Classify alerts for smart monitoring:
-- •	If plan type is Prepaid:
-- o	If monthly bill is greater than 1000:
-- 	If data used (GB) is less than 10:
-- 	If call minutes are less than 200, trigger 'Fraud Alert: Billing Mismatch'.
-- 	Otherwise, trigger 'Alert: High Bill with Low Data'.
-- 	Otherwise, trigger 'Conversion Suggestion: Postpaid'.
-- o	Otherwise:
-- 	If data used (GB) is greater than 30, trigger 'Heavy Data - Check Fair Use'.
-- 	Otherwise, trigger 'Normal Prepaid'.
-- •	If plan type is Postpaid:
-- o	If data used (GB) is greater than 25:
-- 	If call minutes are greater than 1000 and monthly bill is greater than 1000, trigger 'High Usage - Flag for Offer'.
-- 	Otherwise, trigger 'Monitor Postpaid Usage'.
-- o	Otherwise:
-- 	If monthly bill is greater than 900, trigger 'Check Downgrade Option'.
-- 	Otherwise, trigger 'Safe Zone User'.

select *,
case 
	when plan_type = 'Prepaid' then
		case
			when monthly_bill > 1000 then
					case
						when data_used_gb < 10 then
							case
								when call_minutes < 200 then 'Fraud Alert: Billing Mismatch'
                                else 'Alert: High Bill with Low Data'
                            end
                        else 'Conversion Suggestion: Postpaid'
                    end
            else
				case
					when data_used_gb > 30 then 'Heavy Data - Check Fair Use'
                    else 'Normal Prepaid'
                end
        end
    when plan_type = 'Postpaid' then
			case
				when data_used_gb >25 then
					case
						when call_minutes > 1000 and monthly_bill > 1000 then 'High Usage - Flag for Offer'
                        else 'Monitor Postpaid Usage'
                    end
                else
					case
						when monthly_bill > 900 then 'Check Downgrade Option'
                        else 'Check Downgrade Option'
                    end
            end
end as alert
from customerusage
 
