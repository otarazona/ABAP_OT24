CLASS zcl_16_fsvsst DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    METHODS structure.
    METHODS field_symbol.
  PROTECTED SECTION.
  PRIVATE SECTION.

    TYPES lty_flights TYPE STANDARD TABLE OF /dmo/airport WITH NON-UNIQUE KEY airport_id name.

    METHODS loop_fs     CHANGING c_flights TYPE lty_flights.
    METHODS loop_struct CHANGING c_flights TYPE lty_flights.

ENDCLASS.


CLASS zcl_16_fsvsst IMPLEMENTATION.

  METHOD field_symbol.

    DATA lt_flights TYPE lty_flights.

    SELECT FROM /dmo/airport
    FIELDS *
    INTO TABLE @lt_flights.

    LOOP_fs( CHANGING c_flights = lt_flights ).

  ENDMETHOD.

  METHOD structure.

    DATA lt_flights1 TYPE lty_flights.

    SELECT FROM /dmo/airport
    FIELDS *
    INTO TABLE @lt_flights1.

    loop_struct( CHANGING c_flights = lt_flights1 ).

  ENDMETHOD.

  METHOD loop_fs.

    LOOP AT c_flights ASSIGNING FIELD-SYMBOL(<lfs_flight>).
      <lfs_flight>-country = 'CO'.
    ENDLOOP.
  ENDMETHOD.

  METHOD loop_struct.

    LOOP AT c_flights INTO DATA(ls_flight).
      ls_flight-country = 'CO'.
      MODIFY c_flights FROM ls_flight.
    ENDLOOP.

  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.

    DATA(lo_fligths) = NEW zcl_16_fsvsst(  ). "Instancia de la clase
    lo_fligths->structure(  ).
    lo_fligths->field_symbol(  ).

    out->write( 'OK' ).



  ENDMETHOD.



ENDCLASS.
