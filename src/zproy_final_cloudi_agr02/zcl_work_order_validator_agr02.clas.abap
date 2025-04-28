CLASS zcl_work_order_validator_agr02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

    METHODS:
      validate_create_order IMPORTING iv_customer_id   TYPE string
                                      iv_technician_id TYPE string
                                      iv_priority      TYPE string
                            RETURNING VALUE(rv_valid)  TYPE abap_bool,

      validate_update_order IMPORTING iv_work_order_id TYPE zwork_order_id_agr02
                                      iv_status        TYPE string
                                      iv_descrip       TYPE string
                            RETURNING VALUE(rv_valid)  TYPE abap_bool,

      validate_delete_order IMPORTING iv_work_order_id TYPE zwork_order_id_agr02
                                      iv_status        TYPE zstatus_agr02
                            RETURNING VALUE(rv_valid)  TYPE abap_bool,

      validate_status_and_priority IMPORTING iv_status       TYPE string
                                             iv_priority     TYPE string
                                   RETURNING VALUE(rv_valid) TYPE abap_bool.

  PROTECTED SECTION.

  PRIVATE SECTION.

    METHODS:
      check_customer_exists IMPORTING iv_customer_id   TYPE string
                            RETURNING VALUE(rv_exists) TYPE abap_bool,
      check_technician_exists IMPORTING iv_technician_id TYPE string
                              RETURNING VALUE(rv_exists) TYPE abap_bool,
      check_order_exists IMPORTING iv_work_order_id TYPE zwork_order_id_agr02
                         RETURNING VALUE(rv_exists) TYPE abap_bool,
      check_order_history IMPORTING iv_work_order_id TYPE zwork_order_id_agr02
                          RETURNING VALUE(rv_exists) TYPE abap_bool,
      check_priority_exists IMPORTING iv_priority_id   TYPE string
                            RETURNING VALUE(rv_exists) TYPE abap_bool,
      check_status_exists IMPORTING iv_status_id     TYPE string
                          RETURNING VALUE(rv_exists) TYPE abap_bool,
      check_order_status IMPORTING iv_work_order_id TYPE zwork_order_id_agr02
                         RETURNING VALUE(rv_status) TYPE string.


    CONSTANTS: c_valid_status   TYPE   string VALUE 'PE CO', " Example statuses: Pending, Completed
               c_valid_priority TYPE string VALUE 'A B'. " Example priorities: High, Low



ENDCLASS.



CLASS zcl_work_order_validator_agr02 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

  ENDMETHOD.

  METHOD validate_create_order.
    " Check if customer exists
    DATA(lv_customer_exists) = check_customer_exists( iv_customer_id ).
    IF lv_customer_exists IS INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    " Check if technician exists
    DATA(lv_technician_exists) = check_technician_exists( iv_technician_id ).
    IF lv_technician_exists IS INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.


*    " Check if priority exists
    DATA(lv_priority_exists) = check_priority_exists( iv_priority ).
    IF lv_priority_exists IS INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.
    rv_valid = abap_true.
  ENDMETHOD.


  METHOD validate_update_order.
    " Check if the work order exists
    DATA(lv_order_exists) = check_order_exists( iv_work_order_id ).
    IF lv_order_exists IS INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

*    " Check if the order status is editable (e.g., Pending)
    DATA(lv_order_status) = check_order_status( iv_work_order_id ).
    IF lv_order_status NE 'PE'.
      rv_valid = abap_false.
      RETURN.
    ENDIF.
    rv_valid = abap_true.
  ENDMETHOD.

  METHOD validate_delete_order.
    " Check if the order exists
    DATA(lv_order_exists) = check_order_exists( iv_work_order_id ).
    IF lv_order_exists IS INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.
    " Check if the order status is "PE" (Pending)

    IF iv_status NE 'PE'.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    " Check if the order has a history (i.e., if it has been modified before)
    DATA(lv_has_history) = check_order_history( iv_work_order_id ).
    IF lv_has_history IS NOT INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    rv_valid = abap_true.
  ENDMETHOD.

  METHOD validate_status_and_priority.
*    " Validate the status value
    DATA(lv_status_exists) = check_status_exists( iv_status ).
    IF lv_status_exists IS INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

*    " Validate the priority value
    DATA(lv_priority_exists) = check_priority_exists( iv_priority ).
    IF lv_priority_exists IS INITIAL.
      rv_valid = abap_false.
      RETURN.
    ENDIF.

    rv_valid = abap_true.
  ENDMETHOD.



  METHOD check_customer_exists.

    SELECT SINGLE FROM ztcustomer_agr02
      FIELDS *
      WHERE zcust_id = @iv_customer_id
      INTO @DATA(ls_customer).

    IF sy-subrc = 0.
      rv_exists = abap_true.
    ELSE.
      rv_exists = abap_false.
    ENDIF.

  ENDMETHOD.

  METHOD check_order_exists.

    SELECT SINGLE FROM ztwork_order_ag2
 FIELDS *
 WHERE zwork_ord_id = @iv_work_order_id
 INTO @DATA(ls_workorder).

    IF sy-subrc = 0.
      rv_exists = abap_true.
    ELSE.
      rv_exists = abap_false.
    ENDIF.

  ENDMETHOD.

  METHOD check_order_history.

    SELECT SINGLE FROM ztwork_ord_hist
     FIELDS *
     WHERE zwork_ord_id = @iv_work_order_id
     INTO @DATA(ls_work_orderhist).

    IF sy-subrc = 0.
      rv_exists = abap_true.
    ELSE.
      rv_exists = abap_false.
    ENDIF.

  ENDMETHOD.

  METHOD check_technician_exists.

     SELECT SINGLE FROM zttechnician_ag2
  FIELDS *
  WHERE ztech_id = @iv_technician_id
  INTO @DATA(ls_technician).

    IF sy-subrc = 0.
      rv_exists = abap_true.
    ELSE.
      rv_exists = abap_false.
    ENDIF.

  ENDMETHOD.

  METHOD check_order_status.
   SELECT SINGLE FROM ztwork_order_ag2
  FIELDS *
  WHERE zwork_ord_id = @iv_work_order_id
  INTO @DATA(ls_workorder).

    IF sy-subrc = 0.
      rv_status = ls_workorder-zstatus_agr02.
    ELSE.
      rv_status = ''.
    ENDIF.
  ENDMETHOD.

  METHOD check_priority_exists.
    SELECT SINGLE FROM ztpriority_agr02
FIELDS *
WHERE zpriority_code_ag02 = @iv_priority_id
INTO @DATA(ls_priority).

    IF sy-subrc = 0.
      rv_exists = abap_true.
    ELSE.
      rv_exists = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD check_status_exists.
    SELECT SINGLE FROM ztstatus_agr02
FIELDS *
WHERE zstatus_code_agr02 = @iv_status_id
INTO @DATA(ls_priority).

    IF sy-subrc = 0.
      rv_exists = abap_true.
    ELSE.
      rv_exists = abap_false.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
