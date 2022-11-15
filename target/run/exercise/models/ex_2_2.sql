

  create or replace table `dwh-adev-observe`.`zz_xavier`.`ex_2_2`
  
  
  OPTIONS()
  as (
    with users as (
    select
        ua.user_id,
        ua.activity_day,
        ua.activity_type,
        ui.install_day,
        ui.campaign
    from dwh-adev-core.ae_challenge_data.ae_user_activity as ua
        join dwh-adev-core.ae_challenge_data.ae_user_info ui
        on ua.user_id = ui.user_id 
    where ua.activity_type = 'app_open' and DATE_DIFF(u.activity_type, ui.install_day, DAY) <= 6
  ),

last_played_days as (
  select
  u.user_id,
  u.install_day,
  u.campaign,
  from users
  where 7 >= (select count(u2.activity_day) from
  users u2 where u.user_id = u2.user_id)
)

select * from last_played_days
  );
  