{{
    config(
        materialized='incremental',
        unique_key='user_id'
    )
}}

select 
    user_id, 
    min(activity_day) as install_day, 
    'campaign 1' as campaign 
    from dwh-adev-core.ae_challenge_data.ae_user_activity ua
{% if is_incremental() %}

    where not exists (select user_id from {{ this }} 
    where ua.user_id = user_id)

{% endif %}
group by ua.user_id



