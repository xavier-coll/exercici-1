{% set money_segments = [1000, 10000, 20000, 30000, 50000, 100000, 500000] %}

with a1 as (

    {% for x in money_segments%}
    select
    {{x}} as segment,
    ARRAY(select distinct ua.user_id
        from dwh-adev-core.ae_challenge_data.ae_user_activity ua
        where (select sum(ua2.amount) from dwh-adev-core.ae_challenge_data.ae_user_activity ua2
        where ua.user_id = ua2.user_id and ua2.activity_type = "payment" group by ua2.user_id)
        {% if loop.first %}
        between 0 and {{x}}) as user_group
        {% else %}
        between {{loop.previtem}} and {{x}}) as user_group
        {% endif %}
    {% if not loop.last %}
    union all
    {% endif %}
    {% endfor %}
)

select * from a1 order by segment