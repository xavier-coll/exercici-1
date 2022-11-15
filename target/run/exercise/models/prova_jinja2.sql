

  create or replace table `dwh-adev-observe`.`zz_xavier`.`prova_jinja2`
  
  
  OPTIONS()
  as (
    

with a1 as (

    
    select
    1000 as segment,
    ARRAY(select distinct ua.user_id
        from dwh-adev-core.ae_challenge_data.ae_user_activity ua
        where (select sum(ua2.amount) from dwh-adev-core.ae_challenge_data.ae_user_activity ua2
        where ua.user_id = ua2.user_id and ua2.activity_type = "payment" group by ua2.user_id)
        
        between 0 and 1000) as user_group
        
    
    union all
    
    
    select
    10000 as segment,
    ARRAY(select distinct ua.user_id
        from dwh-adev-core.ae_challenge_data.ae_user_activity ua
        where (select sum(ua2.amount) from dwh-adev-core.ae_challenge_data.ae_user_activity ua2
        where ua.user_id = ua2.user_id and ua2.activity_type = "payment" group by ua2.user_id)
        
        between 1000 and 10000) as user_group
        
    
    union all
    
    
    select
    20000 as segment,
    ARRAY(select distinct ua.user_id
        from dwh-adev-core.ae_challenge_data.ae_user_activity ua
        where (select sum(ua2.amount) from dwh-adev-core.ae_challenge_data.ae_user_activity ua2
        where ua.user_id = ua2.user_id and ua2.activity_type = "payment" group by ua2.user_id)
        
        between 10000 and 20000) as user_group
        
    
    union all
    
    
    select
    30000 as segment,
    ARRAY(select distinct ua.user_id
        from dwh-adev-core.ae_challenge_data.ae_user_activity ua
        where (select sum(ua2.amount) from dwh-adev-core.ae_challenge_data.ae_user_activity ua2
        where ua.user_id = ua2.user_id and ua2.activity_type = "payment" group by ua2.user_id)
        
        between 20000 and 30000) as user_group
        
    
    union all
    
    
    select
    50000 as segment,
    ARRAY(select distinct ua.user_id
        from dwh-adev-core.ae_challenge_data.ae_user_activity ua
        where (select sum(ua2.amount) from dwh-adev-core.ae_challenge_data.ae_user_activity ua2
        where ua.user_id = ua2.user_id and ua2.activity_type = "payment" group by ua2.user_id)
        
        between 30000 and 50000) as user_group
        
    
    union all
    
    
    select
    100000 as segment,
    ARRAY(select distinct ua.user_id
        from dwh-adev-core.ae_challenge_data.ae_user_activity ua
        where (select sum(ua2.amount) from dwh-adev-core.ae_challenge_data.ae_user_activity ua2
        where ua.user_id = ua2.user_id and ua2.activity_type = "payment" group by ua2.user_id)
        
        between 50000 and 100000) as user_group
        
    
    union all
    
    
    select
    500000 as segment,
    ARRAY(select distinct ua.user_id
        from dwh-adev-core.ae_challenge_data.ae_user_activity ua
        where (select sum(ua2.amount) from dwh-adev-core.ae_challenge_data.ae_user_activity ua2
        where ua.user_id = ua2.user_id and ua2.activity_type = "payment" group by ua2.user_id)
        
        between 100000 and 500000) as user_group
        
    
    
)

select * from a1 order by segment
  );
  