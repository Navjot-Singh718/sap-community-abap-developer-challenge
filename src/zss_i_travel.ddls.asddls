@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel view'
@Metadata.ignorePropagatedAnnotations: true
@AbapCatalog.extensibility: {
  extensible: true,
  elementSuffix: 'ZAC',
  quota: {
    maximumFields: 500,
    maximumBytes: 5000
  },
  dataSources: [ '_Travel' ]
}

define view entity ZSS_I_Travel
  as select from zss_travel as _Travel
{
  key travel_id     as TravelId,
      description   as Description,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price   as TotalPrice,
      currency_code as CurrencyCode
}
