CLASS zcl_lock_obj_univ_agr02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lock_obj_univ_agr02 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    out->write( |El usuario ya está ejecutando el proceso| ).

    TRY.

        DATA(lo_lock_object) = cl_abap_lock_object_factory=>get_instance(

        EXPORTING

        iv_name = 'EZUNI_AG02'  ).

      CATCH cx_abap_lock_failure.

        out->write( |Objeto de bloqueo no existe| ).

        RETURN.

    ENDTRY.

    TRY.

        DATA lt_parameter TYPE if_abap_lock_object=>tt_parameter.

        lt_parameter = VALUE #( ( name  = 'client '
                                  value = REF #( '100' )  )

                                ( name  = 'soc '
                                  value = REF #( '6000' )  ) ).

*

        lo_lock_object->enqueue(
*  it_table_mode =
               it_parameter  = lt_parameter
*  _scope        =
*  _wait         =
             ).

      CATCH cx_abap_foreign_lock cx_abap_lock_failure.

        out->write( |No es posible escritura, objeto bloqueado| ).

*CATCH cx_abap_lock_failure.

    ENDTRY.

    out->write( |objeto de bloqueo se encuentra activo| ).

    DATA ls_university TYPE zuniversity_ag02.



    ls_university = VALUE #(   soc          = '6000'
                               exercise     = '2025'
                               student_id   = '008'
                               first_name   = 'Santiago'
                               last_name    = 'Pedraza'
                               course_code  = '32'
                               course_price = '80000'
                               currency     = 'COP'
                               courses      = '150'
                               unit         = 'UN'  ).


* Solicitud de desbloqueo

    IF sy-subrc EQ 0.

      out->write( |Business Object| ).

    ENDIF.

    TRY.

        lo_lock_object->dequeue( it_parameter  = lt_parameter ).

      CATCH cx_abap_lock_failure.

        out->write( |Lock Object was NOT released| ).

    ENDTRY.

    out->write( |Lock Object was released| ).


  ENDMETHOD.

ENDCLASS.
