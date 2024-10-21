CLASS zcl_05_operaciones_agora02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES: if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_05_operaciones_agora02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: lv_numa  TYPE i VALUE 20,
          lv_numb  TYPE i VALUE 8,
          lv_total TYPE p LENGTH 6 DECIMALS 2.

***** SUMA

*    lv_total = lv_numa + lv_numb.
*
*    out->write( |Number a = { lv_numa } Number b { lv_numb } Total = { lv_total }| ).
*
*    ADD 5 TO lv_total.
*
*    out->write( lv_total ).
*
*    lv_total += 5.
*
*    out->write( |Total: { lv_total }| ).
*
*    lv_total = lv_numa + lv_numb + lv_total.
*
*    out->write( |Total: { lv_total }| ).
*
*    CLEAR lv_total.
*
*    out->write( | Total = { lv_total } | ).

****** RESTA

*    lv_total = lv_numa - lv_numb.
*
*    out->write( |Number a = { lv_numa } Number b { lv_numb } Total = { lv_total }| ).
*
*
*    SUBTRACT 2 FROM lv_total.
*
*    out->write( lv_total ).

***** Multiplicación
*
*    lv_total = lv_numa * lv_numb.
*
*    out->write( |Number a = { lv_numa } Number b { lv_numb } Total = { lv_total }| ).
*
*    MULTIPLY lv_total BY 5.
*
*    out->write( |Total = { lv_total } | ).

***** División

*    lv_total = lv_numa / lv_numb.
*
*    out->write( |Number a = { lv_numa } Number b { lv_numb } Total = { lv_total }| ).
*
*    DIVIDE lv_total BY 2.
*
*    out->write( |Total = { lv_total } | ).
*
*
*    lv_total = ( lv_numa + lv_numb ) / 3.
*
*    out->write( |Total = { lv_total } | ).

******DIV sin resto

*    lv_numa = 9.
*    lv_numb = 4.
*
*    lv_total = lv_numa / lv_numb.
*
*    out->write( |Total = { lv_total } | ).
*
*    lv_total = lv_numa DIV lv_numb.
*
*    out->write( |Total = { lv_total } | ).

****** MOD

*    lv_total = lv_numa / lv_numb.
*
*    out->write( |Total = { lv_total } | ).
*
*    lv_total = lv_numa MOD lv_numb.
*
*    out->write( |Total = { lv_total } | ).

***** EXP

*    lv_numa = 3.
*    out->write( |numero A = { lv_numa } | ).
*
*    lv_numa = lv_numa ** 2.
*    out->write( |numero A = { lv_numa } | ).
*
*    CLEAR lv_numa.
*
*    lv_numa = 3.
*
*    DATA(lv_exp) = 3.
*
*    lv_numa = lv_numa ** lv_exp.
*    out->write( |numero A = { lv_numa } | ).

***** Función ipow

    DATA(lv_result) = ipow( base = 2 exp = 3 ).

    out->write( lv_result ).


*********Raiz cuadrada SQRT

    lv_numa = sqrt( 25 ).


    out->write( | Total SQRT Raiz cuadrada {  lv_numa } | ).











  ENDMETHOD.
ENDCLASS.
