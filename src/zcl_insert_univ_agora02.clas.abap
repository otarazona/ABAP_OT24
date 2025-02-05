CLASS zcl_insert_univ_agora02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_insert_univ_agora02 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*    DATA: st_University TYPE STANDARD TABLE OF zuniversity_ag02.

    DELETE FROM zuniversity_ag02.

    MODIFY zuniversity_ag02 FROM TABLE @( VALUE #( (
                                                      soc    = '1000'
                                                    exercise = '2025' )

                                                   (
                                                      soc    = '2000'
                                                    exercise = '2025' )

                                                    (
                                                      soc    = '3000'
                                                    exercise = '2025' ) ) ).

    DELETE FROM zuniversity_ag02.

    MODIFY zuniversity_ag02 FROM TABLE @( VALUE #( ( soc          = '1000'
                                                     exercise     = '2025'
                                                     student_id   = '001'
                                                     first_name   = 'Carolina'
                                                     last_name    = 'Mendoza'
                                                     course_code  = '10'
                                                     course_price = '32500'
                                                     currency     = 'COP'
                                                     courses      = '220'
                                                     unit         = 'UN'  )

                                                    ( soc         = '2000'
                                                      exercise    = '2025'
                                                      student_id  = '002'
                                                      first_name  = 'José'
                                                      last_name   = 'Calvo'
                                                      course_code = '18'
                                                      course_price = '50000'
                                                      currency     = 'COP'
                                                      courses      = '340'
                                                      unit         = 'UN' )

                                                    ( soc         = '3000'
                                                      exercise    = '2025'
                                                      student_id  = '003'
                                                      first_name  = 'Manuel'
                                                      last_name   = 'Carvajal'
                                                      course_code = '18'
                                                      course_price = '23900'
                                                      currency     = 'EUR'
                                                      courses      = '399'
                                                      unit         = 'UN' )

                                                    ( soc          = '4000'
                                                      exercise     = '2025'
                                                      student_id   = '004'
                                                      first_name   = 'Laura'
                                                      last_name    = 'Gonzalez'
                                                      course_code  = '20'
                                                      course_price = '65000'
                                                      currency     = 'USD'
                                                      courses      = '143'
                                                      unit         = 'UN' )

                                                    ( soc          = '5000'
                                                      exercise     = '2025'
                                                      student_id   = '005'
                                                      first_name   = 'Daniela'
                                                      last_name    = 'Fonseca'
                                                      course_code  = '23'
                                                      course_price = '71000'
                                                      currency     = 'COP'
                                                      courses      = '420'
                                                      unit         = 'UN' ) ) ).



    IF sy-subrc EQ 0.

      out->write( |{ sy-dbcnt } roows affected| ).
    ENDIF.




  ENDMETHOD.

ENDCLASS.
