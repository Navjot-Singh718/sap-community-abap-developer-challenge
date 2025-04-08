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


   INSERT ztravel_2025 FROM ( SELECT FROM /dmo/travel FIELDS travel_id, total_price, currency_code, description ).

  ENDMETHOD.
ENDCLASS.
