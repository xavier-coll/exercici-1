

select 
    user_id, 
    min(activity_day) as install_day, 
    'campaign 1' as campaign 
    from dwh-adev-core.ae_challenge_data.ae_user_activity ua


    where not exists (select user_id from `dwh-adev-observe`.`zz_xavier`.`ae_user_info_inc` 
    where ua.user_id = user_id)


group by ua.user_id