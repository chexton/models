create or replace view mailship_payments_filtered as (

  select 
    mailship_payments_base.date               as date,
    mailship_payments_base.company_id         as company_id,
    mailship_payments_base.forgiven           as forgiven,
    mailship_payments_base.total              as total,
    mailship_payments_base.kind               as kind,
    mailship_payments_base.yearly             as yearly
  from 
    [mailship_payments_base]
  join 
    [mailship_companies_base]
  on
    mailship_companies_base.id = mailship_payments_base.company_id
  where
    coalesce(
      mailship_companies_base.billing_email,
      mailship_companies_base.name,
      ''
    ) not similar to '%(rzt.back|millionaire|gmail|outlook|yahoo|hotmail|wesupportyou|savingforlife|envanto|pushbuttonprofits|mailmetrash|under30ceo|binary|Binary|fastcashchallenge|wptbootcamp|rushhour)%'
  and
    mailship_companies_base.date is not null
    
);

create or replace view mailship_subscriptions_filtered as (

  select
    *
  from
    [mailship_subscriptions_base]
    
);
