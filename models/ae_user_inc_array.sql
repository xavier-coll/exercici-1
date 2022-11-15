select 
    ua.user_id, 
    min(ua.activity_day) as install_day, 
    'campaign 1' as campaign,
    ARRAY(select ua2.activity_day 
        from dwh-adev-core.ae_challenge_data.ae_user_activity ua2
        where ua.user_id = ua2.user_id) as active_days
    from dwh-adev-core.ae_challenge_data.ae_user_activity ua    
group by ua.user_id

