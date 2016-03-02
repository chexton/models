create or replace view mailship_payments_transformed as (

  select 
    mailship_payments_filtered.company_id         as company_id,
    mailship_payments_filtered.forgiven           as forgiven,
    mailship_payments_filtered.kind               as kind,
    mailship_payments_filtered.yearly             as yearly,
    (select
      timestamp 'epoch' + mailship_payments_filtered.date * interval '1 Second'
    )                                                   as date,
    case
      mailship_payments_filtered.yearly
      when true
      then mailship_payments_filtered.total / 12 / 100  
      else mailship_payments_filtered.total / 100
    end                                                 as total,
    row_number() over(
      partition by mailship_payments_filtered.company_id 
      order by mailship_payments_filtered.date desc
    )                                                   as last_payment,
    row_number() over(
      partition by mailship_payments_filtered.company_id 
      order by mailship_payments_filtered.date asc
    )                                                   as first_payment
  from 
    [mailship_payments_filtered]

);

create or replace view mailship_subscriptions_transformed as (

  select
    *
  from
    [mailship_subscriptions_filtered]
    
);
