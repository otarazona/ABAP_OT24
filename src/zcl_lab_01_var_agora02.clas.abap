CLASS zcl_lab_01_var_agora02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_01_var_agora02 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: mv_purchase_date TYPE d VALUE '20240928',
          mv_purchase_time TYPE t VALUE '100800',
          mv_price         TYPE f VALUE '10.5',
          mv_tax           TYPE i VALUE 16,
          mv_increase      TYPE decfloat16 VALUE '20.5',
          mv_discounts     TYPE decfloat34 VALUE '10.5',
          mv_type          TYPE c LENGTH 10 VALUE 'PC',
          mv_shipping      TYPE p LENGTH 8 DECIMALS 2 VALUE '40.36',
          mv_id_code       TYPE n LENGTH 4 VALUE '1110',
          mv_qr_code       TYPE x LENGTH 5 VALUE 'F5CF'.

    TYPES: BEGIN OF mty_customer,
             id       TYPE i,
             customer TYPE c LENGTH 15,
             age      TYPE i,
           END OF mty_customer.

    DATA ls_customer TYPE mty_customer.

    ls_customer = VALUE #( id       = 12345
                           customer = 'Oscar Tarazona'
                            age     = 43 ).

    out->write( | id { ls_customer-id } Name: { ls_customer-customer } Age: { ls_customer-age }| ).

    out->write( | mv_purchase_date: { mv_purchase_date+6(2) } / { mv_purchase_date+4(2) }  / { mv_purchase_date+0(4) } | ).
    out->write( | mv_purchase_time { mv_purchase_time+0(2) } : { mv_purchase_time+2(2) } : { mv_purchase_time+4(2) }| ).

    " Tipo de referencia

    DATA lvr_ddic_tab TYPE REF TO /dmo/airport.
*    DATA lvr_employees TYPE REF TO snwd_employees.
    DATA lt_employees  TYPE TABLE OF REF TO /dmo/airport.

** Objetos de DATOS

    DATA: mv_product  TYPE string  VALUE 'Laptop',
          mv_bar_code TYPE xstring VALUE '12121121211'.

****Constantes

    CONSTANTS: mc_purchase_date TYPE d VALUE '20240928',
               mc_purchase_time TYPE t VALUE '100800',
               mc_price         TYPE f VALUE '10.5',
               mc_tax           TYPE i VALUE 16,
               mc_increase      TYPE decfloat16 VALUE '20.5',
               mc_discounts     TYPE decfloat34 VALUE '10.5',
               mc_type          TYPE c LENGTH 10 VALUE 'PC',
               mc_shipping      TYPE p LENGTH 8 DECIMALS 2 VALUE '40.36',
               mc_id_code       TYPE n LENGTH 4 VALUE '1110',
               mc_qr_code       TYPE x LENGTH 5 VALUE 'F5CF'.

    DATA(lv_product)  = 'Aceite'.
    DATA(lv_bar_code) = 80010.




  ENDMETHOD.

ENDCLASS.



