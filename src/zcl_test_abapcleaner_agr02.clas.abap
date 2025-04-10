CLASS zcl_test_abapcleaner_agr02 DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    METHODS get_data EXPORTING ev_status TYPE string.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_test_abapcleaner_agr02 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA lv_status TYPE string.

    get_data( IMPORTING ev_status = lv_status ).
    get_data( IMPORTING ev_status = lv_status ).
  ENDMETHOD.

  METHOD get_data.
    SELECT FROM /dmo/flight
      FIELDS *
    " TODO: variable is assigned but never used (ABAP cleaner)
      INTO TABLE @DATA(lt_flights).

    IF sy-subrc = 0.
      ev_status = |Records consulted: { sy-dbcnt }|.
    ELSE.
      ev_status = 'Error'.

    ENDIF.

***


  ENDMETHOD.
ENDCLASS.
