CLASS zcl_work_order_crud_test_ag02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .



  PROTECTED SECTION.

    METHODS:
      test_create_work_order IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out,
      test_read_work_order   IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out,
      test_update_work_order IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out,
      test_delete_work_order IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

  PRIVATE SECTION.

    DATA: mo_handler TYPE REF TO zcl_work_order_crud_handler,
          out        TYPE REF TO object.

ENDCLASS.



CLASS zcl_work_order_crud_test_ag02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    test_create_work_order( out ).
    test_read_work_order( out ).
    test_update_work_order( out ).
    test_delete_work_order( out ).

  ENDMETHOD.



  METHOD test_create_work_order.

    IF mo_handler IS INITIAL.
      CREATE OBJECT mo_handler.
    ENDIF.

    DATA(lv_success) = mo_handler->create_work_order(
         iv_word_order_id   = '0000000004'
         iv_customer_id     = '10000003'
         iv_technician_id   = 'T0000004'
         iv_priority        = 'A'
         iv_status          = 'PE'
         iv_description     = 'Remodelación oficinas'
         iv_creation_date   = sy-datum ).

    IF  sy-subrc = 0. "lv_success = abap_true.
      io_out->write( '✅ Orden creada correctamente.' ).
    ELSE.
      io_out->write( '❌ Error al crear orden.' ) .
    ENDIF.



  ENDMETHOD.


  METHOD test_read_work_order.

    IF mo_handler IS INITIAL.
      CREATE OBJECT mo_handler.
    ENDIF.

    DATA(ls_order) = mo_handler->read_work_order( '0000000003' ).

    IF ls_order-zwork_ord_id IS NOT INITIAL.
      io_out->write( |✅ Orden leída: { ls_order-zdesc_agr02 } | ).
    ELSE.
      io_out->write( '❌ Orden no encontrada.' ).
    ENDIF.

  ENDMETHOD.



  METHOD test_update_work_order.

    IF mo_handler IS INITIAL.
      CREATE OBJECT mo_handler.
    ENDIF.

    DATA(lv_success) = mo_handler->update_work_order(
      iv_work_order_id = '0000000004'
      iv_status        = 'CO'
      iv_priority      = 'B'
      iv_descrip       = 'Remodelación oficinas ' ).

    IF lv_success = abap_true.
      io_out->write( '✅ Orden actualizada.' ).
    ELSE.
      io_out->write( '❌ Error al actualizar orden.' ).
    ENDIF.

  ENDMETHOD.


  METHOD test_delete_work_order.

    IF mo_handler IS INITIAL.
      CREATE OBJECT mo_handler.
    ENDIF.

    DATA(lv_success) = mo_handler->delete_work_order( '0000000002' ).

    IF lv_success = abap_true.
      io_out->write( '✅ Orden eliminada.' ).
    ELSE.
      io_out->write( '❌ No se pudo eliminar la orden.' ).
    ENDIF.



  ENDMETHOD.



ENDCLASS.
