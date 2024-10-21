CLASS zcl_02_datos_complejos_agora2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_02_datos_complejos_agora2 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF lty_empleados,
             id   TYPE i,
             name TYPE string,
             age  TYPE i,
           END OF lty_empleados.

    DATA ls_empleado TYPE lty_empleados.

    ls_empleado = VALUE #( id = 12345
                            name = 'Oscar'
                            age = 43 ).

    TYPES: BEGIN OF ENUM lty_invoice_status,
             fact_pendt,
             pagada,
           END OF ENUM lty_invoice_status.

    DATA lv_status TYPE lty_invoice_status.

    lv_status = fact_pendt.


    out->write( lv_status ).


    out->write( | id { ls_empleado-id } Name: { ls_empleado-name } Age: { ls_empleado-age }| ).


  ENDMETHOD.

ENDCLASS.
