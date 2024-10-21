CLASS zcl_lab_02_arithmetic_agora02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES: if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_02_arithmetic_agora02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: lv_base_rate            TYPE i VALUE 20,
          lv_corp_area_rate       TYPE i VALUE 10,
          lv_medical_service_rate TYPE i VALUE 15,
          lv_total_rate           TYPE i.


***** SUMA

    lv_total_rate = lv_base_rate  + lv_corp_area_rate + lv_medical_service_rate .
*
    out->write( |Total RATE = { lv_total_rate }| ).
*
    ADD 5 TO lv_total_rate.


*
    out->write( lv_total_rate ).
*
******* RESTA

    DATA: lv_maintenance_rate TYPE i VALUE 30,
          lv_margin_rate      TYPE i VALUE 10.

    CLEAR lv_base_rate.


    lv_base_rate = lv_maintenance_rate - lv_margin_rate.
*
    out->write( |Maintenance = { lv_maintenance_rate } Margin Rate = { lv_margin_rate } Total = { lv_base_rate }| ).
*
*
    SUBTRACT 4 FROM lv_base_rate.
*
    out->write( lv_base_rate ).

***** Multiplicación

    DATA: lv_package_weight TYPE i VALUE 2,
          lv_cost_per_kg    TYPE i VALUE 3,
          lv_multi_rate     TYPE i.
*
    lv_multi_rate = lv_package_weight * lv_cost_per_kg.
*
    out->write( |Package weight = { lv_package_weight } Costo per_KG { lv_cost_per_kg } Multi RATE = { lv_multi_rate }| ).
*
    MULTIPLY lv_multi_rate BY 2.
*
    out->write( |Total Incrementado = { lv_multi_rate } | ).

***** División

    DATA: lv_total_weight TYPE i VALUE 38,
          lv_num_packages TYPE i VALUE 4,
          lv_applied_rate TYPE p LENGTH 8 DECIMALS 2.


    lv_applied_rate = lv_total_weight / lv_num_packages.
*
    out->write( |Total División = { lv_applied_rate } | ).
*
    DIVIDE lv_applied_rate BY 3.
*
    out->write( |Total DIV 2 = { lv_applied_rate } | ).
*
*******DIV sin resto


    DATA: lv_total_cost         TYPE i VALUE 17,
          lv_discount_threshold TYPE i VALUE 4,
          lv_result             TYPE p LENGTH 4 DECIMALS 2.


    lv_result = lv_total_cost / lv_discount_threshold.
*
    out->write( |Total con residuo = { lv_result } | ).
*
    lv_result = lv_total_cost DIV lv_discount_threshold.
*
    out->write( |Resultado sin residuo = { lv_result } | ).

****** MOD
    DATA lv_remainder TYPE p LENGTH 4 DECIMALS 2.

    lv_total_cost = 19.

    lv_remainder = lv_total_cost MOD lv_discount_threshold.
*
    out->write( |Total MOD = { lv_remainder } | ).

***** EXP

    DATA: lv_weight TYPE i VALUE 5,
          lv_expo   TYPE i.
*
    lv_expo = lv_weight ** 2.
    out->write( |Resultado EXPO = { lv_expo } | ).
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

    DATA(lv_result1) = ipow( base = 5 exp = 2 ).
*
    out->write( |Resultado función ipow { lv_result1 } | ).


*********Raiz cuadrada SQRT

    DATA(lv_square_root) = sqrt( 25 ).


    out->write( | Total SQRT Raiz cuadrada {  lv_square_root } | ).











  ENDMETHOD.
ENDCLASS.
