CLASS ztravel_fill_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ztravel_fill_data IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DELETE FROM ZSS_TRAVEl.

    INSERT zss_travel FROM ( SELECT FROM /dmo/travel FIELDS travel_id, description, total_price, currency_code,
    CASE
      WHEN total_price > 4500 THEN 'Business'
      WHEN total_price > 300 THEN 'Premium'
      else 'Economy'
      END
  ).
  ENDMETHOD.
ENDCLASS.
