CLASS zcl_insert_data_cust_tecn_ag02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_insert_data_cust_tecn_ag02 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DATA: lt_TCUSTOMER_agr02  TYPE STANDARD TABLE OF ztcustomer_agr02,
          lt_TECHNICIAN_agr02 TYPE STANDARD TABLE OF zttechnician_ag2,
          lt_priority         TYPE STANDARD TABLE OF ztpriority_agr02,
          lt_status           TYPE STANDARD TABLE OF ztstatus_agr02.


    DELETE FROM  ztcustomer_agr02.
    DELETE FROM  zttechnician_ag2.

*INSERT zproducts_agr02 FROM TABLE @( VALUE #(
    lt_TCUSTOMER_agr02 = VALUE #( (  client         = sy-mandt
                                     zcust_id       = 10000000
                                     zname_agr02    = 'Calzado Alitar'
                                     zaddress_agr02 = 'Carrera 11 Núm 23 - 35'
                                     zphone_agr02   = 3950485471 )

                                   ( client         = sy-mandt
                                     zcust_id       = 10000001
                                     zname_agr02    = 'Inversiones ABC'
                                     zaddress_agr02 = 'Av 5 calle 17 - 24'
                                     zphone_agr02   = 3123874502 )

                                   ( client         = sy-mandt
                                     zcust_id       = 10000002
                                     zname_agr02    = 'Oro Rojo ltda'
                                     zaddress_agr02 = 'Panamericana Km 4 vía a la costa'
                                     zphone_agr02   = 3004583210 )

                                   ( client         = sy-mandt
                                     zcust_id       = 10000003
                                     zname_agr02    = 'Oléariari'
                                     zaddress_agr02 = 'Calle 84 # 37 - 62'
                                     zphone_agr02   = 3110948630 )

                                   ( client         = sy-mandt
                                     zcust_id       = 10000004
                                     zname_agr02    = 'Mary Kay'
                                     zaddress_agr02 = 'Av las Americas # 5 - 2'
                                     zphone_agr02   = 6012345786 )

                                   ( client         = sy-mandt
                                     zcust_id       = 10000005
                                     zname_agr02    = 'Freskaleche SA'
                                     zaddress_agr02 = 'KM 7 vía chimitá'
                                     zphone_agr02   = 3104872134 ) ).

    INSERT ztcustomer_agr02 FROM TABLE @lt_tcustomer_agr02.


    lt_technician_agr02 = VALUE #(   ( client         = sy-mandt
                                       ztech_id       = 'T0000001'
                                       zname_agr02    = 'Carlos Mendoza'
                                       zspecialty     = 'Electricista' )

                                     ( client         = sy-mandt
                                       ztech_id       = 'T0000002'
                                       zname_agr02    = 'Miguel Jimenez'
                                       zspecialty     = 'Soldador' )

                                     ( client         = sy-mandt
                                       ztech_id       = 'T0000003'
                                       zname_agr02    = 'Armando Chacón'
                                       zspecialty     = 'Obra civil' )

                                     ( client         = sy-mandt
                                       ztech_id       = 'T0000004'
                                       zname_agr02    = 'Diana Perez'
                                       zspecialty     = 'Diseño Interiores' )

                                     ( client         = sy-mandt
                                       ztech_id       = 'T0000005'
                                       zname_agr02    = 'Bladimir Sanchez'
                                       zspecialty     = 'Hornamentador' ) ).

    INSERT zttechnician_ag2 FROM TABLE @lt_technician_agr02.


     lt_priority = VALUE #(   ( zpriority_code_ag02         = 'A'
                                zpriority_description_ag02  = 'High' )

                              ( zpriority_code_ag02         = 'B'
                                zpriority_description_ag02  = 'Low' ) ).

   INSERT ztpriority_agr02 FROM TABLE @lt_priority.


    lt_status   = VALUE #(   (  zstatus_code_agr02        = 'PE'
                                zstatus_description_ag02  = 'Pending' )

                             (  zstatus_code_agr02        = 'CO'
                                zstatus_description_ag02  = 'Completed' )
                               ).

   INSERT ZTSTATUS_AGR02 FROM TABLE @lt_status.


    IF sy-subrc EQ 0.

      out->write( |LOS REGISTROS FUERON INSERTADOS: { sy-dbcnt }| ).
      out->write( sy-dbcnt ).

    ELSE.

      out->write( 'EL REGISTRO NO FUE INSERTADO' ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.
