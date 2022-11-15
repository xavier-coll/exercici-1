

  create or replace table `dwh-adev-observe`.`zz_xavier`.`copy_user_information`
  
  
  OPTIONS()
  as (
    select * from dwh-adev-core.ae_challenge_data.ae_user_info
  );
  