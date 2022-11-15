{% set action_types = ["app_open", "payment"] %}

select
    u.user_id,
    {% for x in action_types %}
    sum(case when u.activity_type = '{{x}}' then amount end) as {{x}}_amount,
    {% endfor %}
from dwh-adev-core.ae_challenge_data.ae_user_activity u
group by u.user_id
