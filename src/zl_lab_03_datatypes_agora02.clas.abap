CLASS zl_lab_03_datatypes_agora02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES: if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zl_lab_03_datatypes_agora02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

**** Conversiones de tipo

    DATA: mv_char  TYPE c LENGTH 10 VALUE 12345,
          mv_num   TYPE i,
          mv_float TYPE f.
    DATA: lv_string TYPE string VALUE '1235',
          lv_int    TYPE c LENGTH 8.
    lv_int = lv_string.
    out->write( lv_int ).


    mv_num = mv_char.
    mv_float = mv_char.

    out->write( mv_num ).
    out->write( mv_float ).

***** Truncamiento y Redondeo

    DATA: mv_trunc TYPE i,
          mv_round TYPE i.

    CLEAR mv_float.

    mv_float = '123.45'.

    mv_trunc = mv_num.
    out->write( mv_trunc ).

    mv_round = mv_float + '0.5'.

    out->write( mv_round ).

    DATA(lv_text) = 'ABAP'.

**    Conversiones de tipo forzado

    mv_num = CONV i( mv_char ) .

    out->write( | Tipo Forzado { mv_num }| ).


*** Cálculo fecha y hora
    DATA: mv_date_1 TYPE d,
          mv_date_2 TYPE d,
*          mv_days   TYPE i,
          mv_time   TYPE t.

    mv_date_1 = cl_abap_context_info=>get_system_date( ).
    mv_time = cl_abap_context_info=>get_system_time(  ).
    mv_date_2 = '20241031'.

    DATA: lv_cart(8) TYPE c.

    lv_cart = mv_date_2.



    DATA(mv_days) = mv_date_1 - mv_date_2.

    out->write( mv_date_1 ) .
    out->write( mv_time ).
    out->write( mv_days ).

    out->write( |{ mv_date_2+6(2) } / { mv_date_2+4(2) } / { mv_date_2+0(4) } |  ).


* Campos Timestamp

    DATA: mv_timestamp TYPE  utclong.


    mv_timestamp = utclong_current( ).

    out->write( mv_timestamp ).

    CONVERT UTCLONG mv_timestamp
    TIME ZONE cl_abap_context_info=>get_user_time_zone(  )
    INTO DATE mv_date_2
    TIME mv_time.

    out->write( |Fecha { mv_date_2  } | ).
    out->write( |Hora {  mv_time } | ).

    out->write( | Tipo XXXXXXXX { lv_cart }| ).

    DATA: mv_str TYPE string VALUE 'ABAP Cloud',
          mv_ch  TYPE c LENGTH 8.

    mv_ch = mv_str.
    out->write( mv_ch ).






  ENDMETHOD.
ENDCLASS.
