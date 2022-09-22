

  create or replace view `dwh-adev-observe`.`zz_xavier`.`my_second_dbt_model`
  OPTIONS()
  as -- Use the `ref` function to select from other models

select *
from `dwh-adev-observe`.`zz_xavier`.`my_first_dbt_model`
where id = 1;

