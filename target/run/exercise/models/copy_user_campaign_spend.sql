

  create or replace table `dwh-adev-observe`.`zz_xavier`.`copy_user_campaign_spend`
  
  
  OPTIONS()
  as (
    select * from dwh-adev-core.ae_challenge_data.ae_campaign_spend
  );
  