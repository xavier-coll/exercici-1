
        
            
            
        
    

    

    merge into `dwh-adev-observe`.`zz_xavier`.`ae_user_info_inc` as DBT_INTERNAL_DEST
        using (
          

select 
    user_id, 
    min(activity_day) as install_day, 
    'campaign 1' as campaign 
    from dwh-adev-core.ae_challenge_data.ae_user_activity ua


    where not exists (select user_id from `dwh-adev-observe`.`zz_xavier`.`ae_user_info_inc` 
    where ua.user_id = user_id)


group by ua.user_id
        ) as DBT_INTERNAL_SOURCE
        on 
                DBT_INTERNAL_SOURCE.user_id = DBT_INTERNAL_DEST.user_id
            

    
    when matched then update set
        `user_id` = DBT_INTERNAL_SOURCE.`user_id`,`install_day` = DBT_INTERNAL_SOURCE.`install_day`,`campaign` = DBT_INTERNAL_SOURCE.`campaign`
    

    when not matched then insert
        (`user_id`, `install_day`, `campaign`)
    values
        (`user_id`, `install_day`, `campaign`)


  