CLASS zcl_department_code_agr02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_department_code_agr02 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA lv_depart TYPE c LENGTH 10 VALUE 'FR'.

    AUTHORITY-CHECK OBJECT  'ZAODEPAGR2'
           ID 'ZAF_DEPART' FIELD '02'.


    SELECT FROM /dmo/airport
        FIELDS *
        INTO TABLE @DATA(lt_airport).

    IF sy-subrc = 0.

      out->write( lt_airport ).

     ELSE.

     out->write( 'No tiene autorización para esta consulta' ).

    ENDIF.

  ENDMETHOD.

ENDCLASS.
