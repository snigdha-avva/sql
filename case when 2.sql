use dec12;
CREATE TABLE CustomerUsage (
 customer_id INT PRIMARY KEY,
 customer_name VARCHAR(50),
 plan_type VARCHAR(20),
 data_used_gb INT,
 call_minutes INT,
 monthly_bill DECIMAL(10,2)
);

INSERT INTO CustomerUsage VALUES
(1, 'Veena', 'Postpaid', 9, 471, 842.03),
(2, 'Veer', 'Postpaid', 7, 354, 434.94),
(3, 'Mohan', 'Prepaid', 33, 497, 569.23),
(4, 'Pratik', 'Prepaid', 15, 113, 1107.48),
(5, 'Farhan', 'Prepaid', 14, 1284, 845.75),
(6, 'Jiya', 'Postpaid', 28, 1578, 1325.15);

-- Question 1:
-- Evaluate potential for plan upgrade:
-- If plan_type = 'Prepaid':
-- •	If monthly_bill > 400 OR call_minutes > 550 → 'Suggest Postpaid Upgrade'
-- •	Else → 'No Upgrade'
-- If plan_type = 'Postpaid':
-- •	If data_used_gb > 25 → 'Suggest Premium Plan'
-- •	Else → 'Satisfactory Usage'

select *,
case
when plan_type = 'Prepaid' then
          case 
			when monthly_bill > 400 OR call_minutes > 550 then 'Suggest Postpaid Upgrade'
            else 'No Upgrade'
          end
when plan_type = 'Postpaid' then
           case
			 when data_used_gb > 25 then 'Suggest Premium Plan'
             else 'Satisfactory Usage'
           end
end as plan_upgrade
from CustomerUsage;

-- Question 2:
-- Classify customers based on data usage and plan type:
-- If plan_type = 'Postpaid':
-- •	If data_used_gb >= 30 → 'Heavy User - Postpaid'
-- •	Else If data_used_gb BETWEEN 15 AND 29 → 'Moderate User - Postpaid'
-- •	Else → 'Light User - Postpaid'
-- If plan_type = 'Prepaid':
-- •	If data_used_gb >= 20 → 'Heavy User - Prepaid'
-- •	Else → 'Light User - Prepaid'


select *,case
when plan_type = 'Postpaid' then 
						case
							when data_used_gb >= 30 then 'Heavy User - Postpaid'
                            when data_used_gb BETWEEN 15 AND 29 then 'Moderate User - Postpaid'
                            else 'Light User - Postpaid'
                        end
when plan_type = 'Prepaid' then
					case
						when data_used_gb >= 20 then 'Heavy User - Prepaid'
                        else 'Light User - Prepaid'
                    end
end as customer_category
from CustomerUsage;

-- Question 3:
-- Assess voice usage pattern:
-- If call_minutes > 1200:
-- •	If monthly_bill > 1000 → 'Excessive Talker - Premium'
-- •	Else → 'Excessive Talker - Standard'
-- Else If call_minutes BETWEEN 800 AND 1200 → 'Frequent Caller'
-- Else → 'Normal Caller'

select *,case
when call_minutes > 1200 then
             case 
				when monthly_bill > 1000 then 'Excessive Talker - Premium'
                else 'Excessive Talker - Standard'
             end
when call_minutes BETWEEN 800 AND 1200 then 'Frequent Caller'
else 'Normal Caller'
end as voice_usage_pattern
from CustomerUsage

-- Determine offer eligibility:
-- If plan_type = 'Postpaid' AND data_used_gb > 25 AND call_minutes > 1000 → 'Combo Offer'
-- If plan_type = 'Prepaid' AND monthly_bill > 600 → 'Recharge Cashback Offer'
-- Else → 'No Offer'

select *,case
when plan_type = 'Postpaid' AND data_used_gb > 25 AND call_minutes > 1000 then 'Combo Offer'
when plan_type = 'Prepaid' AND monthly_bill > 600 then 'Recharge Cashback Offer'
else 'No Offer'
end as offer_eligibility
from CustomerUsage;

-- Question 5:
-- Reward program allocation:
-- If data_used_gb > 25:
-- •	If call_minutes > 1000 → 'Gold Tier'
-- •	Else → 'Silver Tier'
-- Else:
-- •	If call_minutes > 800 → 'Bronze Tier'
-- •	Else → 'Basic Tier'

select *,
case 
when data_used_gb > 25 then
			case
				when call_minutes > 1000 then 'Gold Tier'
                else 'Silver Tier'
            end
else 
	case
		when call_minutes > 800 then 'Bronze Tier'
        else 'Basic Tier'
	end
end as reward_program
 from CustomerUsage;
 
 -- Question 6:
-- Detect mismatched usage patterns:
-- If plan_type = 'Postpaid' AND monthly_bill < 500 → 'Underutilized Postpaid'
-- If plan_type = 'Prepaid' AND monthly_bill > 900 → 'Overpaying Prepaid'
-- Else → 'Plan Matches Usage'

select *, case
when plan_type = 'Postpaid' AND monthly_bill < 500 then 'Underutilized Postpaid'
when plan_type = 'Postpaid' AND monthly_bill < 500 then 'Underutilized Postpaid'
else 'Plan Matches Usage'
end as mismatched_uasgae_patterns
from CustomerUsage

-- Question 7:
-- Identify heavy all-round users:
-- If data_used_gb > 25 AND call_minutes > 1000:
-- •	If monthly_bill > 1200 → 'Super User'
-- •	Else → 'High Usage Customer'
-- Else → 'Standard User'
select * ,case
	when data_used_gb > 25 AND call_minutes > 1000 then
			case
				when monthly_bill > 1200 then 'Super User'
                else 'High Usage Customer'
            end
    else 'Standard User'
 end as all_round_users 
from customerusage;

-- Question 8:
-- Voice vs Data Preference:
-- If call_minutes > data_used_gb * 30 → 'Voice Oriented User'
-- If data_used_gb > call_minutes / 30 → 'Data Oriented User'
-- Else → 'Balanced Usage'

select *,case 
when call_minutes > data_used_gb * 30 then 'Voice Oriented User'
when data_used_gb > call_minutes / 30 then 'Data Oriented User'
else 'Balanced Usage'
end as preference 
from customerusage;

-- Suggest billing discounts:
-- If monthly_bill > 1000:
-- •	If plan_type = 'Prepaid' → 'Offer Switch + Discount'
-- •	If plan_type = 'Postpaid' → 'Offer Loyalty Discount'
-- Else → 'No Discount'

select *,case 
when monthly_bill > 1000 then 
			case
				when plan_type = 'Prepaid' then 'Offer Switch + Discount'
                when plan_type = 'Postpaid' then 'Offer Loyalty Discount'
			end
else 'No Discount'
end as discounts
from customerusage;

-- Question 10:
-- Assign digital engagement tag:
-- If data_used_gb > 25:
-- •	If monthly_bill < 700 → 'High Efficiency User'
-- •	Else → 'Premium Digital User'
-- Else → 'Standard Engagement'

select *,
case
when data_used_gb > 25  then 
		case
			when monthly_bill < 700  then 'High Efficiency User'
            else 'Premium Digital User'
        end
else 'Standard Engagement'
end as tag
from customerusage

-- Question 11:
-- If call_minutes > 1500 AND data_used_gb < 10 → 'Heavy Voice, Low Data'
-- If data_used_gb > 25 AND call_minutes < 500 → 'Heavy Data, Light Talk'
-- Else → 'Balanced or Low Usage'

select *,
case
	when call_minutes > 1500 AND data_used_gb < 10 then 'Heavy Voice, Low Data'
    when data_used_gb > 25 AND call_minutes < 500 then 'Heavy Data, Light Talk'
    else 'Balanced or Low Usage'
end as usage_1
from customerusage

-- Question 12:
-- If plan_type = 'Postpaid' AND monthly_bill > 800:
-- •	If call_minutes > 1200 → 'Elite Postpaid User'
-- •	Else → 'Premium Postpaid User'
-- If plan_type = 'Prepaid' → 'Prepaid User'

select *,
case 
	when plan_type = 'Postpaid' AND monthly_bill > 800 then 
			case
				when call_minutes > 1200 then 'Elite Postpaid User'
                else 'Premium Postpaid User'
			end
    when plan_type = 'Prepaid' then 'Prepaid User'
end as user_type
 from customerusage

-- If data_used_gb > 20 AND monthly_bill BETWEEN 800 AND 1000 → 'Gold Data Pack Suggested'
-- Else If data_used_gb > 30 → 'Platinum Data Pack Suggested'
-- Else → 'Standard Plan'

select *,
case 
	when data_used_gb > 20 AND monthly_bill BETWEEN 800 AND 1000 then 'Gold Data Pack Suggested'
    when data_used_gb > 30 then 'Platinum Data Pack Suggested'
    else 'Standard Plan'
end as plan
 from customerusage
 
--  If call_minutes > 1000:
-- •	If monthly_bill < 700 → 'Value Talker'
-- •	Else → 'Premium Talker'
-- Else → 'Normal Caller'

select *,
case 
	when  call_minutes > 1000 then 
		case
			when monthly_bill < 700 then 'Value Talker'
            else 'Premium Talker'
        end
    else 'Normal Caller'
end as talker
from customerusage


-- Question 15:
-- If plan_type = 'Prepaid' AND data_used_gb > 25 → 'Prepaid Power User'
-- If plan_type = 'Postpaid' AND data_used_gb > 25 → 'Postpaid Power User'
-- Else → 'Normal User'

select *,
case
	when plan_type = 'Prepaid' AND data_used_gb > 25 then 'Prepaid Power User'
    when plan_type = 'Postpaid' AND data_used_gb > 25 then 'Postpaid Power User'
    else 'Normal User'
end user_type
 from customerusage
 
