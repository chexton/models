create or replace view stripe_analysis_invoices_transformed as (
  
  select 
      mailship_subscriptions_transformed.company_id             as company_id,
      stripe_analysis_invoices_filtered.customer                as customer,
      (
        timestamp 'epoch' + stripe_analysis_invoices_filtered.date * interval '1 Second'
      )                                                         as date,
      stripe_analysis_invoices_filtered.forgiven                as forgiven,
      stripe_analysis_invoices_filtered.paid                    as paid,
      case  stripe_analysis_plans_transformed.interval
        when 'yearly'
        then stripe_analysis_invoices_filtered.total / 12 / 100 
        else stripe_analysis_invoices_filtered.total /100  
      end                                                       as total,
      row_number() over(
        partition by stripe_analysis_invoices_filtered.customer 
        order by stripe_analysis_invoices_filtered.date desc
      )                                                         as last_payment,
      row_number() over(
        partition by stripe_analysis_invoices_filtered.customer 
        order by stripe_analysis_invoices_filtered.date asc
      )                                                         as first_payment
    from 
      [stripe_analysis_invoices_filtered]
    join
      [stripe_analysis_subscriptions_transformed]
    on
      stripe_analysis_invoices_filtered.subscription = stripe_analysis_subscriptions_transformed.id
    join
      [stripe_analysis_plans_transformed]
    on
      stripe_analysis_subscriptions_transformed.plan_id = stripe_analysis_plans_transformed.id
    join
      [mailship_subscriptions_transformed]
    on
      stripe_analysis_invoices_filtered.customer = mailship_subscriptions_transformed.stripeCustomerId

);

create or replace view stripe_analysis_subscriptions_transformed as (

  select 
    *
  from 
    [stripe_analysis_subscriptions_filtered]

);

create or replace view stripe_analysis_plans_transformed as (

  select 
    *
  from 
    [stripe_analysis_plans_filtered]

);