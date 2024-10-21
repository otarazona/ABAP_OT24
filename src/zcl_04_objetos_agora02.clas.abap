CLASS zcl_04_objetos_agora02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES: if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_04_objetos_agora02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: lv_num1 TYPE i VALUE 10,
          lv_num2 TYPE i,
          lv_num3 TYPE i.


    CONSTANTS: lc_num4   TYPE i VALUE 10,
               lc_num5   TYPE i VALUE 20,
               lc_string TYPE string VALUE 'ABAP'.

    lv_num2 = 15.

    lv_num3 = lv_num1 + lv_num2.


    DATA(lv_invoice) = '01234XC'.
    DATA(lv_tax)     = 1234.

    DATA lv_letra  TYPE string.

    lv_letra = '01ABC'.

    out->write( lv_letra ).

    out->write( |value1= { lv_num1 } Value 2 = { lv_num2 } Value 3 = { lv_num3 }| ).

******** Literales

    out->write( 'ABAP Class - Logali' ).
    out->write( |Estudiante Agora 02| ).



  ENDMETHOD.

ENDCLASS.
