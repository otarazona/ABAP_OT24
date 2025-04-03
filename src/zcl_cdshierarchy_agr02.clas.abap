CLASS zcl_cdshierarchy_agr02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cdshierarchy_agr02 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    DELETE FROM zavi_parent_ag02.

    INSERT zavi_parent_ag02 FROM TABLE @( VALUE #(
                                                    ( id = 1 parent_id = 0 aviation_name = 'Aviation 1' )
                                                    ( id = 2 parent_id = 1 aviation_name = 'Aviation 2' )
                                                    ( id = 3 parent_id = 2 aviation_name = 'Aviation 3' )
                                                    ( id = 1 parent_id = 2 aviation_name = 'Aviation 1' ) ) ).


    SELECT FROM zavi_parent_ag02
    FIELDS *
    INTO TABLE @DATA(lt_tree_parent).

    IF sy-subrc = 0.

*      out->write( lt_tree_parent ).

    ENDIF.

    DATA lc_var TYPE i VALUE 1.
    TRY.
        SELECT FROM HIERARCHY( SOURCE zcds_aviation_agr02( pid = @lc_var  )
         CHILD TO PARENT ASSOCIATION _Aviation
         START WHERE id = 1
      SIBLINGS ORDER BY id ASCENDING
*         DEPTH 2 " Define niveles de jerarquías, profundidad
      MULTIPLE PARENTS ALLOWED " multiples nodos padres
      ORPHANS ROOT " Nodos Huérfanos
        CYCLES BREAKUP ) " Realiza el salto de una excepción y continua con los demás nodos
        FIELDS Id,
               ParentId,
               AviationName
          INTO TABLE @DATA(lt_result).


        IF lt_result IS NOT INITIAL.
*          out->write( lt_result ).
        ENDIF.

      CATCH cx_sy_open_sql_db INTO DATA(lx_sql_db).
        out->write( lx_sql_db->get_text( ) ).
    ENDTRY.

****Path Expression - Asociations

SELECT from /DMO/I_FLIGHT
FIELDS AirlineID,
       ConnectionID,
       FlightDate,
       \_Airline-Name as name1,
       \_Airline[ CurrencyCode = 'EUR' ]-Name AS airlineNameEUR,
       \_Airline\_Currency-CurrencyISOCode,
       \_Airline\_Currency\_Text[ Language = 'E' and Currency = 'EUR' ]-CurrencyShortName
       ORDER BY FlightDate DESCENDING
       INTO TABLE @DATA(LT_FLIGHT).

  IF sy-subrc = 0.

*      out->write( lt_flight ).

    ENDIF.

*** CDS con parámetros

 SELECT FROM zcds_aviation_agr02( pId = @lc_var )
    FIELDS *
      INTO TABLE @DATA(lt_results).
IF sy-subrc = 0.

      out->write( lt_results ).

    ENDIF.

  ENDMETHOD.

ENDCLASS.
