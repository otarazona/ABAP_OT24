CLASS zcl_16_perform_tabla_int_agr02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_16_perform_tabla_int_agr02 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    TYPES lty_flights TYPE STANDARD TABLE OF /dmo/flight WITH NON-UNIQUE KEY carrier_id connection_id flight_date.

    DATA lt_flights TYPE lty_flights.

    lt_flights = VALUE #( ( client        = sy-mandt
                            carrier_id    = 'CO'
                            connection_id = '0500'
                            flight_date   = '20250201'
                            plane_type_id = '123-456'
                            price         = '1000'
                            currency_code = 'COP' )
                          ( client        = sy-mandt
                            carrier_id    = 'MX'
                            connection_id = '0600'
                            flight_date   = '20250201'
                            plane_type_id = '747-400'
                            price         = '800'
                            currency_code = 'MXN' )
                          ( client        = sy-mandt
                            carrier_id    = 'QF'
                            connection_id = '0006'
                            flight_date   = '20250201'
                            plane_type_id = 'A380'
                            price         = '1600'
                            currency_code = 'AUD' )
                          ( client        = sy-mandt
                            carrier_id    = 'CO'
                            connection_id = '0500'
                            flight_date   = '20250201'
                            plane_type_id = '321-654'
                            price         = '100'
                            currency_code = 'EUR' )
                          ( client        = sy-mandt
                            carrier_id    = 'LX'
                            connection_id = '0900'
                            flight_date   = '20250201'
                            plane_type_id = '258-963'
                            price         = '50'
                            currency_code = 'COP' ) ).

    out->write( 'Before sort' ).
    out->write( lt_flights ).

    " SORT WITH PRIMARY KEY
*
*    SORT lt_flights.
*
*    out->write( 'sort BY PRIMARY KEY' ).
*    out->write( lt_flights ).
*
*    " SORT WITH ANY FIELDS
*
*    SORT lt_flights BY currency_code plane_type_id.
*    out->write( 'sort BY TWO FIELDS' ).
*    out->write( lt_flights ).
*
*    " SORT WITH ANY FIELDS ASCENDING and DESCENDING
*
*    SORT lt_flights BY carrier_id ASCENDING flight_date DESCENDING.
*    out->write( 'sort BY ASCENDING and DESCENDING' ).
*    out->write( lt_flights ).

    "DELETE ADJACENT DUPLICATES
    SORT lt_flights BY carrier_id connection_id.
    DELETE ADJACENT DUPLICATES FROM lt_flights COMPARING carrier_id connection_id.


    " REDUCCIONES

    TYPES: BEGIN OF lty_total,
             price    TYPE /dmo/flight_price,
             seatsocc TYPE /dmo/plane_seats_occupied,
           END OF lty_total.

    DATA lt_flights_red TYPE TABLE OF /dmo/flight.


    SELECT FROM /dmo/flight
    FIELDS *
    INTO TABLE @lt_flights_red.


    DATA(lv_sum) = REDUCE i( INIT lv_result = 0
                             FOR ls_flight_red IN lt_flights_red
                             NEXT lv_result += ls_flight_red-price ).

    out->write( 'SUMA OF FLIGTHS PRICE' ).
    out->write( lV_SUM ).
    out->write( ' ' ).

    " Operaciones con campos estructurados

    DATA(ls_data) = REDUCE lty_total( INIT ls_totalS TYPE lty_total
                                       FOR ls_flight_red2 IN lt_flights_red
                                       NEXT ls_totals-price    += ls_flight_red2-price
                                            ls_totals-seatsocc += ls_flight_red2-seats_occupied ).

    out->write( 'SUMA OF FLIGTHS PRICE AND SEATS OCUPIED' ).
    out->write( ls_data ).
    out->write( ' ' ).














  ENDMETHOD.

ENDCLASS.
