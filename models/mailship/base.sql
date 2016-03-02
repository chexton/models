create or replace view mailship_payments_base as (

  select 
    payments.date               as date,
    payments.company_id         as company_id,
    payments.forgiven           as forgiven,
    payments.total              as total,
    payments.kind               as kind,
    payments.yearly             as yearly
  from 
    payments

);

create or replace view mailship_subscriptions_base as (

  select
    subscriptions.company_id            as company_id,
    subscriptions.stripeCustomerId      as stripe_customer_id
  from
    subscriptions
    
);

create or replace view mailship_companies_base as (

  select 
    companies.id                as id,
    companies.billing_email     as billing_email,
    companies.company_id        as company_id,
    companies.name              as name
  from 
    companies

);
