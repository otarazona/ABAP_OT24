CLASS zcl_sql_push_down_agr02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_push_down_agr02 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

SELECT  FROM /DMO/I_Flight
FIELDS *
WHERE price GT 500
INTO TABLE @data(lt_flight).

 IF sy-subrc = 0.
      out->write( data = lt_flight name = |Vuelos Superiores a 500| ).
    ENDIF.

***ESPECIFICACIONES DE COLUMNAS


SELECT FROM /dmo/flight
FIELDS CARRIER_ID,
       CONNECTION_ID

INTO TABLE @data(lt_carrier).

 IF sy-subrc = 0.

      out->write( cl_abap_char_utilities=>newline ).
      out->write( data = lt_carrier name = |Lineas Aereas y conexiones| ).
    ENDIF.

****VARIABLES DE HOST

    DATA:
      lv_price   TYPE /DMO/I_Flight-Price VALUE 500,
      lv_carrier TYPE /dmo/carrier_id   VALUE 'LH'.


    SELECT FROM /dmo/flight
    FIELDS carrier_id,
           price
    WHERE carrier_id EQ @lv_carrier AND  price GT @lv_price
    INTO TABLE @DATA(lt_vuelos).

    IF sy-subrc = 0.

      out->write( cl_abap_char_utilities=>newline ).
      out->write( data = lt_vuelos name = |vuelos según aerolinea especifica| ).

    ENDIF.

***CASE

    SELECT FROM /dmo/flight
        FIELDS carrier_id,
               connection_id,
               price,
               CASE WHEN price <  500 THEN 'Low'
                    WHEN price >= 500 AND price <= 1000 THEN 'Medium'
                    WHEN price > 1000 THEN 'High'
                    ELSE 'Outside the category'
               END AS clasificat
          INTO TABLE @DATA(lt_flights).

    IF sy-subrc = 0.
      out->write( data = lt_flights name = |lt_flights| ).
    ENDIF.

***TABLAS TEMPORALES GLOBALES

    DATA lt_temp_flight TYPE STANDARD TABLE OF ztem_fligh_agr02.

    lt_temp_flight = VALUE #( ( carrier_id     = 'SQ'
                              connection_id  = '0001'
                              flight_date    = '20250320'
                              price          = '8200'
                              currency_code  = 'EUR'
                              plane_type_id  = 'AGR-002'
                              seats_max      = '90'
                              seats_occupied = '75' ) ).

    INSERT ztem_fligh_agr02 FROM TABLE @lt_temp_flight.

    SELECT FROM ztem_fligh_agr02
       FIELDS *
         INTO TABLE @DATA(lt_temp_Content).

    SELECT FROM ztem_fligh_agr02 AS tf INNER JOIN /dmo/flight AS df
             ON tf~carrier_id = df~carrier_id
          AND tf~connection_id = df~connection_id
    FIELDS    tf~carrier_id,
              tf~connection_id,
              df~price,
              df~plane_type_id
    INTO TABLE @DATA(lt_inner).

    IF lt_inner IS NOT INITIAL.
      out->write( cl_abap_char_utilities=>newline ).
      out->write( data = lt_temp_Content name = |vuelos tabla temporal| ).
      out->write( cl_abap_char_utilities=>newline ).
      out->write( data = lt_inner name = |Precio de los vuelos| ).
    ENDIF.

***Subconsulta WITH

    WITH +temp_table AS (
    SELECT FROM /dmo/flight
    FIELDS carrier_id,
           connection_id,
           price
     WHERE price GT 500 )

        SELECT FROM /dmo/flight AS fl
         INNER JOIN +temp_table AS tf
            ON fl~carrier_id = tf~carrier_id
           AND fl~connection_id = tf~connection_id
        FIELDS fl~carrier_id, fl~connection_id, fl~price
          INTO TABLE @DATA(lt_result).

    IF lt_result IS NOT INITIAL.
      out->write( lt_result ).
    ENDIF.

***Inserción / Modificación – Subconsulta

INSERT zspfli_agr02 FROM ( select from /dmo/carrier
                            FIELDS carrier_id,
                                   name,
                                   currency_code
                            WHERE currency_code eq 'EUR'   ).

select from zspfli_agr02
 FIELDS *
 INTO TABLE @data(lt_info).

IF sy-subrc eq 0.

out->write( 'Los registros se han insertado' ).
out->write( data = lt_info name = |Información tabla zspfli_agr02| ).
ENDIF.

***HINTS

  SELECT FROM /dmo/flight
    FIELDS carrier_id, connection_id, price
   %_HINTS HDB 'INDEX_SEARCH'
      INTO TABLE @DATA(lt_HINTS).

    IF sy-subrc eq 0.
      out->write( lt_HINTS ).
    ENDIF.

****UNION

 SELECT FROM /dmo/flight
    FIELDS carrier_id, connection_id, price
     WHERE price LT 4000
     UNION ALL
    SELECT FROM /dmo/flight
    FIELDS carrier_id, connection_id, price
     WHERE price GT 6000
      INTO TABLE @DATA(lt_union).

    IF sy-subrc eq 0.
      out->write( lt_union ).
    ENDIF.

***INTERSECT

 SELECT FROM /dmo/flight
    FIELDS carrier_id,
           connection_id,
           price
     WHERE price GT 4000
 INTERSECT
    SELECT FROM /dmo/flight
    FIELDS carrier_id,
           connection_id,
           price
     WHERE price LT 6000
      INTO TABLE @DATA(lt_intersect).

   IF sy-subrc eq 0.
      out->write( data = lt_intersect name = 'INTERSEPCION' ).
    ENDIF.





****EXCEPT

  SELECT FROM /dmo/flight
    FIELDS carrier_id,
           connection_id,
           price
     WHERE price GT 4000
    EXCEPT
    SELECT FROM /dmo/flight
    FIELDS carrier_id,
           connection_id,
           price
    WHERE price GT 6000
    INTO TABLE @DATA(lt_except).


   IF sy-subrc eq 0.
      out->write( data = lt_except name = 'EXCEPCION' ).
    ENDIF.


  ENDMETHOD.

ENDCLASS.
















