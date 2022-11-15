

  create or replace table `dwh-adev-observe`.`zz_xavier`.`model1`
  
  
  OPTIONS()
  as (
    with elegible_users as (
  select
    d1.user_id as USER_ID,
    d2.campaign as campaign,
    d1.amount as spent,
    d1.activity_day as date_act
  from dwh-adev-core.ae_challenge_data.ae_user_activity as d1
  join dwh-adev-core.ae_challenge_data.ae_user_info as d2
  on d1.user_id = d2.user_id
  where (DATE_DIFF(d1.activity_day, d2.install_day, DAY) < 7 and d1.activity_type = 'payment')
  order by d1.user_id DESC
),

spent_per_user as (
  select distinct
      elegible_users.USER_ID,
      sum(elegible_users.spent) as money,
      elegible_users.campaign
  from elegible_users
  group by 
      elegible_users.campaign, elegible_users.USER_ID

),

spent_per_user_campaign as (
  select sum(cs.dollar_spend) as money,
  eu.USER_ID as user_id,
  eu.campaign,
  from elegible_users as eu, dwh-adev-core.ae_challenge_data.ae_campaign_spend as cs
  where eu.date_act = cs.spend_day and cs.campaign = eu.campaign
  group by eu.USER_ID, eu.campaign
),

final as (
  select
  eu.USER_ID, eu.money as user_spent_money, eu.campaign, su.money as money_spent_on_campaign
  from spent_per_user as eu join spent_per_user_campaign as su on 
  eu.USER_ID = su.USER_ID
  order by eu.USER_ID asc

)

select * from final
  );
  