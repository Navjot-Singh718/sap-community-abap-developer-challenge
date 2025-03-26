"!@testing
CLASS ltc_zss_ext_i_travel DEFINITION FINAL
  FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.

  PRIVATE SECTION.
    CLASS-DATA environment TYPE REF TO if_cds_test_environment.

    DATA td_zss_travel TYPE STANDARD TABLE OF zss_travel WITH EMPTY KEY.
    DATA td_/dmo/i_booking_u TYPE STANDARD TABLE OF /dmo/i_booking_u WITH EMPTY KEY.
    DATA act_results TYPE STANDARD TABLE OF zss_i_travel WITH EMPTY KEY.

    "! In CLASS_SETUP, corresponding doubles and clone(s) for the CDS view under test and its dependencies are created.
    CLASS-METHODS class_setup RAISING cx_static_check.
    "! In CLASS_TEARDOWN, Generated database entities (doubles & clones) should be deleted at the end of test class execution.
    CLASS-METHODS class_teardown.

    "! SETUP method creates a common start state for each test method,
    "! clear_doubles clears the test data for all the doubles used in the test method before each test method execution.
    METHODS setup RAISING cx_static_check.
    METHODS prepare_testdata.
    "! In this method test data is inserted into the generated double(s) and the test is executed and
    "! the results should be asserted with the actuals.
    METHODS : aunit_for_cds_method FOR TESTING RAISING cx_static_check,
      "! Check for value greater than 1000
      above_threshold              FOR TESTING,

      "! Check for value lower than 1000
      below_threshold              FOR TESTING,

      "! Check for initial value
      initial_value                FOR TESTING,

      "! Check for value 1000
      equal_to_threshold           FOR TESTING.
ENDCLASS.


CLASS ltc_zss_ext_i_travel IMPLEMENTATION.

  METHOD class_setup.
    environment = cl_cds_test_environment=>create( i_for_entity = 'ZSS_I_TRAVEL' ).
  ENDMETHOD.

  METHOD setup.
    environment->clear_doubles( ).
  ENDMETHOD.

  METHOD class_teardown.
    environment->destroy( ).
  ENDMETHOD.

  METHOD aunit_for_cds_method.
    prepare_testdata( ).
    SELECT * FROM zss_i_travel INTO TABLE @act_results.
*    cl_abap_unit_assert=>fail( msg = 'Place your assertions here' ).
  ENDMETHOD.

  METHOD prepare_testdata.
    " Prepare test data for 'zss_travel'
    td_zss_travel = VALUE #(
      (
        client = '100'
      ) ).
    environment->insert_test_data( i_data = td_zss_travel ).

    " Prepare test data for '/dmo/i_booking_u'
    " TODO: Provide the test data here
    td_/dmo/i_booking_u = VALUE #(
      (
      ) ).
    environment->insert_test_data( i_data = td_/dmo/i_booking_u ).
  ENDMETHOD.

  METHOD above_threshold.
    " Fill in test data
    DATA flight_mock_data TYPE STANDARD TABLE OF zss_travel WITH EMPTY KEY.
    flight_mock_data = VALUE #( ( total_price = '1500' ) ).
    environment->insert_test_data( i_data =  flight_mock_data ).

    " Execute test
    SELECT SINGLE ZZDiscPriceZAC FROM zss_i_travel INTO @DATA(act_result).

    " Check result
    cl_abap_unit_assert=>assert_equals( act = act_result exp = '1350' msg = 'PriceWithDiscount' ).
  ENDMETHOD.

  METHOD below_threshold.
    " Fill in test data
    DATA flight_mock_data TYPE STANDARD TABLE OF zss_travel WITH EMPTY KEY.
    flight_mock_data = VALUE #( ( total_price = '500' ) ).
    environment->insert_test_data( i_data =  flight_mock_data ).

    " Execute test
    SELECT SINGLE ZZDiscPriceZAC FROM zss_i_travel INTO @DATA(act_result).

    " Check result
    cl_abap_unit_assert=>assert_equals( act = act_result exp = '500' msg = 'PriceWithDiscount' ).
  ENDMETHOD.

  METHOD equal_to_threshold.
    " Fill in test data
    DATA flight_mock_data TYPE STANDARD TABLE OF zss_travel WITH EMPTY KEY.
    flight_mock_data = VALUE #( ( total_price = '1000' ) ).
    environment->insert_test_data( i_data =  flight_mock_data ).

    " Execute test
    SELECT SINGLE ZZDiscPriceZAC FROM zss_i_travel INTO @DATA(act_result).

    " Check result
    cl_abap_unit_assert=>assert_equals( act = act_result exp = '1000' msg = 'PriceWithDiscount' ).
  ENDMETHOD.

  METHOD initial_value.
    " Fill in test data
    DATA flight_mock_data TYPE STANDARD TABLE OF zss_travel WITH EMPTY KEY.
    flight_mock_data = VALUE #( ( total_price = '' ) ).
    environment->insert_test_data( i_data =  flight_mock_data ).

    " Execute test
    SELECT SINGLE ZZDiscPriceZAC FROM zss_i_travel INTO @DATA(act_result).

    " Check result
    cl_abap_unit_assert=>assert_equals( act = act_result exp = '0' msg = 'PriceWithDiscount' ).
  ENDMETHOD.

ENDCLASS.
