CLASS zcl_work_order_crud_handler DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  INTERFACES if_oo_adt_classrun .

    METHODS:
      create_Work_order IMPORTING iv_word_order_id TYPE zwork_order_id_agr02
                                  iv_customer_id   TYPE string
                                  iv_technician_id TYPE string
                                  iv_priority      TYPE string
                                  iv_status        TYPE string
                                  iv_description   TYPE string
                                  iv_creation_date TYPE d

                        EXPORTING ev_valid         TYPE abap_bool
                                  ev_message       TYPE string

                        RETURNING VALUE(rv_success) TYPE abap_bool,

      read_work_order   IMPORTING iv_work_order_id TYPE zwork_order_id_agr02

                        EXPORTING ev_valid         TYPE abap_bool
                                  ev_message       TYPE string


                        RETURNING VALUE(rs_order)    TYPE ztwork_order_ag2,


      update_work_order IMPORTING iv_work_order_id  TYPE zwork_order_id_agr02
                                  iv_status         TYPE string
                                  iv_priority       TYPE string
                                  iv_descrip        TYPE string

                        RETURNING VALUE(rv_success) TYPE abap_bool,


      delete_work_order IMPORTING iv_work_order_id   TYPE zwork_order_id_agr02

                        RETURNING VALUE(rv_success)  TYPE abap_bool.



  PROTECTED SECTION.



  PRIVATE SECTION.

  DATA: mo_validator TYPE REF TO zcl_work_order_validator_agr02.

ENDCLASS.



CLASS zcl_work_order_crud_handler IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

  ENDMETHOD.



  METHOD create_work_order.

    " Validaciones
    IF mo_validator IS INITIAL.
      CREATE OBJECT mo_validator.
    ENDIF.

    DATA(lv_valid) = mo_validator->validate_create_order(
      iv_customer_id   = iv_customer_id
      iv_technician_id = iv_technician_id
      iv_priority      = iv_priority  ).

    IF lv_valid = abap_false.
      ev_valid = abap_false.
      RETURN.
    ENDIF.

    " Insertar la orden
    DATA(ls_order) = VALUE ZTWORK_ORDER_AG2( zwork_ord_id    = iv_word_order_id
                                             zcust_id        = iv_customer_id
                                             ztech_id        = iv_technician_id
                                             zcreat_dat      = iv_creation_date "sy-datum
                                             zstatus_agr02   = iv_status "'PE'
                                             zpriority_agr02 = iv_priority
                                             zdesc_agr02     = iv_description ).

    INSERT ZTWORK_ORDER_AG2 FROM @ls_order.
    IF sy-subrc = 0.
      ev_valid = abap_true.
    ELSE.
      ev_valid = abap_false.
    ENDIF.



  ENDMETHOD.

  METHOD read_work_order.

    SELECT SINGLE *
    FROM ztwork_order_ag2
    WHERE zwork_ord_id = @iv_work_order_id
    INTO @rs_order.

  " Si no se encuentra, devolver estructura vacía
  IF sy-subrc <> 0.
    CLEAR rs_order.
  ENDIF.


  ENDMETHOD.

  METHOD update_work_order.

   IF mo_validator IS INITIAL.
    CREATE OBJECT mo_validator.
  ENDIF.

  " Validar antes de modificar
  DATA(lv_valid) = mo_validator->validate_update_order(
    iv_work_order_id = iv_work_order_id
    iv_status        = iv_status
    iv_descrip      = iv_descrip
  ).

  IF lv_valid = abap_false.
    rv_success = abap_false.
    RETURN.
  ENDIF.

  " Actualizar registro
  UPDATE ztwork_order_ag2 SET
    zstatus_agr02   = @iv_status,
    zpriority_agr02 = @iv_priority,
    zdesc_agr02     = @iv_descrip

    WHERE zwork_ord_id = @iv_work_order_id.

  IF sy-subrc = 0.
    rv_success = abap_true.
  ELSE.
    rv_success = abap_false.
  ENDIF.

  ENDMETHOD.

  METHOD delete_work_order.

IF mo_validator IS INITIAL.
    CREATE OBJECT mo_validator.
  ENDIF.

  " Leer estado actual de la orden
  DATA(ls_order) = VALUE ztwork_order_ag2( ).

  SELECT SINGLE *
    FROM ztwork_order_ag2
    WHERE zwork_ord_id = @iv_work_order_id
    INTO @ls_order.

  IF sy-subrc <> 0.
    rv_success = abap_false.
    RETURN.
  ENDIF.

  " Validar si puede eliminarse
  DATA(lv_valid) = mo_validator->validate_delete_order(
    iv_work_order_id = iv_work_order_id
    iv_status        = ls_order-zstatus_agr02 ).

  IF lv_valid = abap_false.
    rv_success = abap_false.
    RETURN.
  ENDIF.

  " Eliminar orden
  DELETE FROM ztwork_order_ag2 WHERE zwork_ord_id = @iv_work_order_id.

  IF sy-subrc = 0.
    rv_success = abap_true.
  ELSE.
    rv_success = abap_false.
  ENDIF.


  ENDMETHOD.



ENDCLASS.
