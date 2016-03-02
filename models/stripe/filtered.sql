create or replace view stripe_analysis_invoices_filtered as (

  select 
    *
  from 
    [stripe_analysis_invoices_base]

);

create or replace view stripe_analysis_subscriptions_filtered as (

  select 
    *
  from 
    [stripe_analysis_subscriptions_base]

);

create or replace view stripe_analysis_plans_filtered as (

  select 
    *
  from 
    [stripe_analysis_plans_base]

);