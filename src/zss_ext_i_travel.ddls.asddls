extend view entity ZSS_I_Travel with
association to /DMO/I_Booking_U as _ZZBooking on $projection.TravelId = _ZZBooking.TravelID
{

  _Travel.zztraveltypezac as zzTravelTypezac,
  @Semantics.amount.currencyCode: 'CurrencyCode'
  case
  when _Travel.total_price <= 1000 or _Travel.total_price is initial
    then cast(_Travel.total_price as /dmo/flight_price preserving type )
  else
    cast(
       cast( _Travel.total_price as abap.dec(16,2) )  * division( 9, 10, 2 ) as /dmo/flight_price
        )
   end                    as ZZDiscPriceZAC,
   
 _ZZBooking.FlightDate as ZZFlightDateZAC,
 
 case
  when  _ZZBooking.FlightDate > $session.system_date 
    then dats_days_between( $session.system_date, _ZZBooking.FlightDate)
    end as ZZDaysRemainingZAC
 
}
