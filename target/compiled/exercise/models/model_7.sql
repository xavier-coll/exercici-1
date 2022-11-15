declare days ARRAY<INT64> DEFAULT [7,30,60];

declare d_index INT64 default 0;
declare maxd_index INT64 default ARRAY_LENGTH(days);



while d_index < maxd_index do
with elegible_users as (
  select
    d1.user_id as USER_ID,
    d2.campaign as campaign,
    d1.amount as spent,
    d1.activity_day as date_act,
    d2.install_day as inst_day
  from dwh-adev-core.ae_challenge_data.ae_user_activity as d1
  join dwh-adev-core.ae_challenge_data.ae_user_info as d2
  on d1.user_id = d2.user_id
  where (DATE_DIFF(d1.activity_day, d2.install_day, DAY) < days[offset(d_index)]+1 and d1.activity_type = 'payment')
  order by d1.user_id DESC
),

spent_per_user as (
  select
      elegible_users.USER_ID,
      sum(elegible_users.spent) as money,
  from elegible_users
  group by 
      elegible_users.USER_ID

),

spent_per_user_campaign as (
  select
  cs.dollar_spend as money,
  eu.USER_ID as user_id,
  eu.campaign,
  from elegible_users as eu, dwh-adev-core.ae_challenge_data.ae_campaign_spend as cs
  where eu.inst_day = cs.spend_day and cs.campaign = eu.campaign
),

final as (
  select distinct
    su.USER_ID as user_id, 
    su.money as user_spent_money, 
    sc.campaign as Campaign, 
    sc.money as money_spent_on_campaign,
    days[offset(d_index)] as days_since_install 
  from spent_per_user as su join spent_per_user_campaign as sc on 
  su.USER_ID = sc.USER_ID
)

select * from final;

end while;