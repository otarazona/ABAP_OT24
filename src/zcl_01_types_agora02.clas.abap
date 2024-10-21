CLASS zcl_01_types_agora02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_01_types_agora02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: lv_string TYPE string, "Cadena de caracteres
          lv_int    TYPE i VALUE 20250110, " variable de tipo entero
          lv_date   TYPE d,
          lv_dec    TYPE p LENGTH 8 DECIMALS 2 VALUE '202501.10',
          lv_cart   TYPE c LENGTH 10 VALUE 'logali'.

    lv_string = '20250110'.
    lv_date   = lv_string.

    out->write( lv_string ).
    out->write( lv_int ).
    out->write( |{ lv_date+6(2) } / { lv_date+4(2) } / { lv_date+4 } |  ).
    out->write( lv_dec ).
    out->write( lv_cart ).
    out->write( 'Esta es mi primera CLASS' ).
    out->write( TEXT-001 ).
  ENDMETHOD.

ENDCLASS.
