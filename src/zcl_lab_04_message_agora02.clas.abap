CLASS zcl_lab_04_message_agora02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES: if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_04_message_agora02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: lv_order_status TYPE string VALUE ' Purchase Completed Successfully   ',
          lv_char_number  TYPE i.

* Text Symbols

    out->write( lv_order_status ).
    out->write( TEXT-001 ).
    out->write( TEXT-msg ).

* Funciones de descripción

    lv_char_number = strlen( lv_order_status ).
    out->write( lv_char_number ).

    lv_char_number = numofchar( lv_order_status ).
    out->write( lv_char_number ).

*Count
    lv_char_number = count( val = lv_order_status sub = 'A' case = abap_false ).
    out->write( lv_char_number ).

    " Find

    lv_char_number = find( val = lv_order_status sub = 'Exit' case = abap_false ).

    out->write( lv_char_number ).

*Funciones de procesamiento
*ORDER
    out->write( | to_upper              = { to_upper( lv_order_status ) } | ).
    out->write( | to_lower              = { to_lower( lv_order_status ) } | ).
    out->write( | to_mixed              = { to_mixed( lv_order_status ) } | ).
    out->write( | from_mixed            = { from_mixed( lv_order_status ) } | ).
    out->write( | to_mixed              = { to_mixed( lv_order_status ) } | ).
    out->write( | shift_left (circ)     = { shift_left( val = lv_order_status circular = 9 ) } | ).
    out->write( | Reverse               = { reverse( lv_order_status ) } | ).


* Substring

    out->write( | SUBSTRING              = { substring( val =  lv_order_status off = 9 len = 10 ) } | ).

* Funciones de contenido

    DATA: lv_pattern TYPE string VALUE '\d{3}-\d{3}-\d{4}',
          lv_phone   TYPE string VALUE '317-332-0882'.


    IF contains( val = lv_phone pcre = lv_pattern  ).

      out->write( | Telefono consistente: { lv_phone } | ).

    ELSE.

      out->write( 'El telefono es inconsistente, corrija' ).

    ENDIF.

    DATA lv_email TYPE string VALUE 'otarazona@agoracsc.com'.

    LV_PATTERn = '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'.

    IF contains( val = lv_email pcre = lv_pattern  ).

      out->write( | Correo correcto: { lv_email } | ).

    ELSE.

      out->write( 'El correo es inconsistente, corrija' ).

    ENDIF.


  ENDMETHOD.

ENDCLASS.
