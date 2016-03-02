create or replace view stripe_analysis_invoices_base as (

  select 
    production.vero_stripe_production.stripe_invoices.customer     as customer,
    production.vero_stripe_production.stripe_invoices.date         as date,
    production.vero_stripe_production.stripe_invoices.forgiven     as forgiven,
    production.vero_stripe_production.stripe_invoices.subscription as subscription,
    production.vero_stripe_production.stripe_invoices.total        as total
  from 
    production.vero_stripe_production.stripe_invoices

);

create or replace view stripe_analysis_subscriptions_base as (

  select 
    production.vero_stripe_production.stripe_subscriptions.id        as id,
    production.vero_stripe_production.stripe_subscriptions.plan__id  as plan_id
  from 
    production.vero_stripe_production.stripe_subscriptions

);

create or replace view stripe_analysis_plans_base as (

  select 
    production.vero_stripe_production.stripe_plans.id               as id,
    production.vero_stripe_production.stripe_plans.interval         as interval
  from 
    production.vero_stripe_production.stripe_plans

);


