

  create or replace table `dwh-adev-observe`.`zz_xavier`.`prova_jinja`
  
  
  OPTIONS()
  as (
    

select
    u.user_id,
    
    sum(case when u.activity_type = 'app_open' then amount end) as app_open_amount,
    
    sum(case when u.activity_type = 'payment' then amount end) as payment_amount,
    
from dwh-adev-core.ae_challenge_data.ae_user_activity u
group by u.user_id

  );
  