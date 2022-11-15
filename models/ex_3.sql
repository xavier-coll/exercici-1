select 
    user_id, 
    min(activity_day) as install_day, 
    'campaign 1' as campaign 
    from dwh-adev-core.ae_challenge_data.ae_user_activity ua
    where ua.activity_day <= '2021-09-6'
    group by ua.user_id