with users as (
    select
        ua.user_id,
        ua.activity_day,
        7 = DATE_DIFF(ua.activity_day,MIN(ua.activity_day) over (partition by ua.user_id order by ua.activity_day ROWS
        BETWEEN 7 PRECEDING AND 0 PRECEDING), DAY) as has_been_active
    from dwh-adev-core.ae_challenge_data.ae_user_activity ua
    where ua.activity_type = 'app_open'
  )

select * from users