

  create or replace table `dwh-adev-observe`.`zz_xavier`.`model_test`
  
  
  OPTIONS()
  as (
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
  where d1.activity_type = 'payment'
),

spent_per_user as (
  select
      elegible_users.USER_ID,
      sum(if(DATE_DIFF(elegible_users.date_act, elegible_users.inst_day, DAY) < 8, elegible_users.spent, null)) as spent_money_7_days,
      sum(if(DATE_DIFF(elegible_users.date_act, elegible_users.inst_day, DAY) < 31, elegible_users.spent, null)) as spent_money_30_days,
      sum(if(DATE_DIFF(elegible_users.date_act, elegible_users.inst_day, DAY) < 61, elegible_users.spent, null)) as spent_money_60_days,
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
    su.spent_money_7_days,
    su.spent_money_30_days,
    su.spent_money_60_days, 
    sc.campaign as campaign_name, 
    sc.money as money_spent_on_campaign,
  from spent_per_user as su join spent_per_user_campaign as sc on 
  su.USER_ID = sc.USER_ID
)

select * from final
  );
  