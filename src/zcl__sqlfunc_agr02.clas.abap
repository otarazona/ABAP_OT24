CLASS zcl__sqlfunc_agr02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl__sqlfunc_agr02 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


**Funciones Númericas

    SELECT SINGLE FROM /dmo/flight
    FIELDS carrier_id,
           connection_id,
           flight_date,
           seats_max,
           seats_occupied,
           CAST( price AS FLTP ) / CAST( seats_max AS FLTP ) AS Ratio,
           division( price, seats_max, 2 ) AS Division,
*       div( price, seats_max ) as Div, " The operators DIV and MOD cannot be used in expressions that contain real decimal numbers such as PRICE.
*       mod( price, seats_max ) " The operators DIV and MOD cannot be used in expressions that contain real decimal numbers such as PRICE.
            div( seats_max, seats_occupied ) AS div,
            mod( seats_max, seats_occupied ) AS mod,
            abs( seats_max - seats_occupied ) AS abs,
            ceil( price ) AS ceil,
            floor( price ) AS floor,
            round( price, 2 ) AS round
    WHERE carrier_id = 'LH' AND connection_id = '400'
           INTO @DATA(Ls_FLIGHT).

    IF sy-subrc EQ 0.
*     out->write( Ls_FLIGHT ).
    ENDIF.

***Funciones de concatenación

    CONSTANTS lc_char TYPE c LENGTH 10 VALUE 'Airlines'.

    SELECT SINGLE FROM /dmo/carrier
    FIELDS carrier_id,
           name,
           concat( name, @lc_char ) AS contat,
           concat_with_space( name, @lc_char, 1 ) AS contat_with,
           name && @lc_char AS name_amp
           WHERE carrier_id = 'AA'
           INTO @DATA(ls_dat_res).

* IF sy-subrc eq 0.
*     out->write( ls_dat_res ).
*    ENDIF.

***Concatenacion cadena de caracteres
    SELECT SINGLE FROM /dmo/flight
    FIELDS carrier_id,
                connection_id,
                flight_date,
                left( carrier_id, 2 )             AS left_id,
                right( carrier_id, 2 )            AS right_id,
                lpad( carrier_id, 5, '0' )        AS lpad_id,
                rpad( carrier_id, 5, '0' )        AS rpad_id,
                ltrim( carrier_id, 'L' )          AS ltrim_id,
                rtrim( carrier_id, 'H' )          AS rtrim_id,
                instr( carrier_id, 'LH' )         AS instr_id,
                substring( carrier_id, 1, 2 )     AS substring_id,
                length( carrier_id )              AS length_id,
                replace( carrier_id, 'LH', 'XX' ) AS replace_id,
                lower( carrier_id )               AS lower_id,
                upper( carrier_id )               AS upper_id
         WHERE carrier_id = 'LH'
         INTO @DATA(ls_cadena).

* IF sy-subrc eq 0.
*     out->write( ls_cadena ).
*    ENDIF.

** 4. Funciones para Fechas

    SELECT SINGLE FROM /dmo/flight
  FIELDS carrier_id,
         connection_id,
         flight_date,

         dats_is_valid( flight_date ) AS valid_date,
         dats_add_days( flight_date, 30 ) AS add_date,
         dats_days_between( flight_date, flight_date ) AS days_between,
         dats_add_months( flight_date, -2 ) AS add_months
         WHERE carrier_id = 'LH' AND connection_id = '400'
         INTO @DATA(ls_fechas).

    IF sy-subrc EQ 0.
*      out->write( ls_fechas ).
    ENDIF.

***5. Funciones para Timestamp

    DATA lt_temp_flights TYPE ztem_fligh_agr02.
    GET TIME STAMP FIELD DATA(lv_timestamp).

    lt_temp_flights = VALUE #( client = 100
                                   carrier_id = 'SQ'
                                   connection_id = '0001'
                                   flight_date = cl_abap_context_info=>get_system_date( )
                                   time = lv_timestamp ).


    INSERT ztem_fligh_agr02 FROM @lt_temp_flights.

    SELECT SINGLE FROM ztem_fligh_agr02
    FIELDS carrier_id,
           connection_id,
           flight_date,
                   tstmp_is_valid( time ) AS valid_timestamp, " Valida si el valor de la variable es correcta
                   tstmp_seconds_between( tstmp1 = tstmp_current_utctimestamp( ),
                                          tstmp2 = tstmp_add_seconds( tstmp = time,
                                         seconds = CAST( 60 AS DEC( 15,0 ) ) ),
                                        on_error = @sql_tstmp_seconds_between=>set_to_null ) AS seconds_between
                                        INTO @DATA(ls_times).

    IF sy-subrc EQ 0.
*      out->write( ls_times ).
    ENDIF.


**Funciones para Uso Horario

    SELECT SINGLE FROM /dmo/flight
    FIELDS carrier_id,
           connection_id,
           flight_date,
           abap_user_timezone( on_error = @sql_abap_user_timezone=>set_to_null ) AS user_timezone,
           abap_system_timezone( on_error = @sql_abap_system_timezone=>set_to_null ) AS system_timezone
    WHERE carrier_id = 'LH' AND connection_id = '400'
    INTO @DATA(ls_uso).

    IF sy-subrc EQ 0.
*      out->write( ls_uso ).
    ENDIF.
***7. Conversiones – Fechas y Timestamps

    DATA: lv_tzone TYPE timezone,
          lv_time  TYPE t.

    SELECT SINGLE FROM /dmo/flight
    FIELDS carrier_id,
           connection_id,
           flight_date,
*       tstmp_current_utctimestamp( ) as current_utc,
               tstmp_current_utctimestamp( )                            AS current_utc,
               tstmp_to_tims( tstmp = tstmp_current_utctimestamp( ),
                              tzone = @lv_tzone )                       AS to_tims,
               tstmp_to_dst( tstmp = tstmp_current_utctimestamp( ),
                             tzone = @lv_tzone )                        AS to_dst,
               dats_tims_to_tstmp( date  = flight_date,
                                   time  = @lv_time,
                                   tzone = @lv_tzone )                  AS to_tstmp


    WHERE carrier_id = 'LH' AND connection_id = '400'
    INTO @DATA(ls_conver).

    IF sy-subrc EQ 0.
*      out->write( ls_conver ).
    ENDIF.


****Conversion de importe y cantidades

    DATA lv_currency TYPE /dmo/currency_code.

    lv_currency = 'USD'.


    TRY.
        SELECT SINGLE
         FROM /dmo/flight
       FIELDS carrier_id,
              connection_id,
              flight_date,
              price,
              currency_conversion( amount = price,
                                   source_currency = currency_code,
                                   target_currency = @lv_currency,
                                   exchange_rate_date = @( cl_abap_context_info=>get_system_date( ) ),
                                   round = 'X' ,
                                   on_error   = @sql_currency_conversion=>c_on_error-set_to_null ) AS converted_amount,
                                   'USD' AS converted_currency
        WHERE carrier_id EQ 'LH' AND connection_id EQ '0400'
         INTO @DATA(ls_impcant).

      CATCH cx_sy_open_sql_db INTO DATA(lx_sql_db).
        out->write( lx_sql_db->get_text(  ) ).
        RETURN.
    ENDTRY.

    IF sy-subrc EQ 0.
*      out->write( ls_impcant ).
    ENDIF.


***Extracciones - propiedades fechas

    SELECT SINGLE FROM /dmo/flight
         FIELDS carrier_id,
                connection_id,
                flight_date,
                extract_year( flight_date )  AS year,
                extract_month( flight_date ) AS month,
                extract_day( flight_date )   AS day
         WHERE carrier_id = 'LH' AND connection_id = '400'
         INTO @DATA(ls_result).

    " Display results
    IF ls_result IS NOT INITIAL.
      out->write( ls_result ).
    ENDIF.

****10.UUID – Universal Unique Identifier

    DELETE FROM zspfli_agr02.

    INSERT zspfli_agr02 FROM ( SELECT FROM /dmo/flight
                               FIELDS uuid( ) AS id,
                                      carrier_id,
                                      currency_code ).

    SELECT FROM zspfli_agr02
    FIELDS *
      INTO TABLE @DATA(ls_uuid).

    IF ls_result IS NOT INITIAL.
      out->write( ls_uuid ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
















