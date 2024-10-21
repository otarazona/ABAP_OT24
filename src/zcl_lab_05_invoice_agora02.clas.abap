CLASS zcl_lab_05_invoice_agora02 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES: if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_05_invoice_agora02 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA: mv_exercise(4)   TYPE n,
          MV_INVOICE_No(8) TYPE n,
          mv_invoice_code  TYPE string.

    mv_exercise = 2024.
    MV_INVOICE_No = '12345678'.

*Concatenar

    CONCATENATE  mv_exercise MV_INVOICE_No INTO mv_invoice_code SEPARATED BY '-'.

    out->write( | Factura de Venta { mv_invoice_code } | ).

    SELECT FROM zemp_logali
    FIELDS id
    INTO TABLE @DATA(lt_employees).

    DATA(lv_employees_itab) = concat_lines_of(  table = lt_employees sep = '-'  ).

    out->write( lv_employees_itab ).



***** Condese

    DATA: mv_case1 TYPE string VALUE 'Sales invoice with         status in process',
          mv_case2 TYPE string VALUE '***ABAP*Cloud***'.

    out->write( mv_case1 ).

    CONDENSE  mv_case1.
    out->write( mv_case1 ).


*****Eliminar valores

    mv_case2 = condense( val = mv_case2 del = '*' ).

    out->write( mv_case2 ).

***** SPLIT

    DATA: mv_data        TYPE string VALUE '0001111111;LOGALI GROUP;2024',
          mv_id_customer TYPE string,
          mv_customer    TYPE string,
          mv_year        TYPE string.


    SPLIT mv_data AT ';' INTO mv_id_customer mv_customer mv_year.

    out->write( mv_id_customer ).
    out->write( mv_customer ).
    out->write( mv_year ).

*    SHIFT

    DATA mv_invoice_num TYPE string VALUE '2015ABCD'.

    SHIFT mv_invoice_num RIGHT DELETING TRAILING 'CD'.

    SHIFT mv_invoice_num LEFT DELETING LEADING 'AB'.

    out->write( mv_invoice_num ).

*Funciones STRLEN y NUMOFCHAR

    DATA: mv_response TYPE string VALUE `Generating Invoice  `,
          mv_count    TYPE string.


    mv_count = strlen( mv_response ).
    out->write( mv_count ).

    mv_count = numofchar( mv_response ).

    out->write( mv_count ).



* Funciones TO_LOWER y TO_UPPER

    DATA mv_translate_invoice TYPE string VALUE 'Report the issuance of this invoice'.

    mv_translate_invoice = to_upper( mv_translate_invoice ).

    out->write( mv_translate_invoice ).

    mv_translate_invoice = to_lower( mv_translate_invoice ).

    out->write( mv_translate_invoice ).

*    TRANSLATE

    TRANSLATE mv_translate_invoice TO UPPER CASE.
    out->write( mv_translate_invoice ).

    TRANSLATE mv_translate_invoice TO LOWER CASE.
    out->write( mv_translate_invoice ).

*Función INSERT y REVERSE


    mv_translate_invoice = insert( val = mv_translate_invoice sub = `to client `  ).


    out->write( mv_translate_invoice ).

    mv_translate_invoice = reverse( val = mv_translate_invoice ).

    out->write( mv_translate_invoice ).

*OVERLAY

    DATA(lv_sale)        = '        Purchase Completed'.
    DATA(lv_sale_status) = 'Invoice                   '.

    OVERLAY lv_sale_status WITH lv_sale.
    out->write( lv_sale_status ).

*    Función SUBSTRING

    DATA(lv_result) = 'SAP-ABAP-32-PE'.
    out->write( lv_result ).

    lv_result = substring( val = lv_result off = 9 len = 5 ).
    out->write( lv_result ).

    DATA(lv_result1) = 'SAP-ABAP-32-PE'.

    lv_result1 = substring_from( val = lv_result1 sub = 'ABAP' ).
    out->write( | Resultado 1: { lv_result1 } |  ).

    DATA(lv_result2) = 'SAP-ABAP-32-PE'.

    lv_result2 = substring_after( val = lv_result2 sub = 'ABAP' ).
    out->write( | Resultado 2: { lv_result2 } |  ).

    DATA(lv_result3) = 'SAP-ABAP-32-PE'.

    lv_result3 = substring_before( val = lv_result3 sub = 'ABAP' ).
    out->write( | Resultado 3: { lv_result3 } |  ).


*FIND

    DATA: lv_status TYPE string VALUE 'INVOICE GENERATED SUCCESSFULLY',
          lv_count  TYPE i.

    lv_count = find_any_of( val = lv_status sub = 'GEN' ).

    lv_count = sy-fdpos + 1.

    out->write( | Busqueda XXXXX: { lv_count } |  ).

    FIND ALL OCCURRENCES OF 'A' IN lv_status MATCH COUNT lv_count.
    out->write( | Busqueda1: { lv_count } |  ).

*    REGEX

    DATA: lv_regex TYPE string VALUE '^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$', "para validar el formato de los correos electrónicos.
          lv_email TYPE string VALUE 'otarazona@agoracsc.com'.


*    DATA(lv_find) = find( val = lv_email regex = lv_regex ).
*    out->write( | Correo: { lv_find } |  ).

    FIND REGEX lv_regex IN lv_email MATCH COUNT lv_count.
    out->write( | Correo: { lv_count } |  ).

    IF lv_count >= 0.
      out->write( | Correo valido: { lv_email } |  ).

    ELSE.

      out->write( | Correo invalido: { lv_email } |  ).

    ENDIF.

*REPLACE

    DATA lv_request TYPE string VALUE 'SAP-ABAP-32-PE'.

    REPLACE '-' WITH '/' INTO lv_request.
    out->write( lv_request ).

    REPLACE ALL OCCURRENCES OF '-' IN lv_request WITH '/'.
    out->write( lv_request ).


*PCRE Regex

    DATA(lv_regex1) = '^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$'. "para validar el formato de los correos electrónicos.
    DATA(lv_email1) = 'otarazona@agoracsc.com'.

    FIND PCRE lv_regex1 IN lv_email1.

    IF sy-subrc EQ 0.
      out->write( 'ok' ).

    ELSE.

      out->write( 'No Ok' ).

    ENDIF.

*Expresiones regulares


    lv_regex = '0*'.
    DATA lv_idcustome TYPE string VALUE '0000012345'.


    REPLACE ALL OCCURRENCES OF PCRE lv_regex IN lv_idcustome WITH space.

    out->write( lv_idcustome ).

*Repetición de strings

* Repetir un valor con la función REPEAT()

    lv_idcustome = repeat( val = lv_idcustome occ = 3 ).

    out->write( lv_idcustome ).

* Función ESCAPE

    DATA lv_format TYPE string VALUE 'Send payment data via Internet'.

    " URL
    DATA(lv_url) = escape( val = lv_format  format = cl_abap_format=>e_uri_full ).

    out->write( lv_url ).

    " JSON Logali "ABAP" test json \ Academy @300

    DATA(lv_json) = escape( val = lv_format  format = cl_abap_format=>e_json_string ).

    out->write( lv_json ).

    "String Templates

    DATA(lv_templates) = escape( val = lv_format  format = cl_abap_format=>e_string_tpl ).

    out->write( lv_templates ).

    DATA mv_invoice_XX TYPE c LENGTH 10 VALUE '      ABCD'.


    SHIFT mv_invoice_XX LEFT DELETING LEADING space.

    out->write( mv_invoice_XX ).


*FIND

    DATA: lv_sTR      TYPE string VALUE 'ABAP CLOUD',
          lv_position TYPE i.

    lv_position = find_any_of( val = lv_sTR sub = 'OU' ).

*    lv_position = sy-fdpos + 1.

    out->write( | Busqueda XXXXX: { lv_position } |  ).

    DATA: lv_resulta TYPE string VALUE '1234567890'.

    lv_resulta = substring( val = lv_resulta off = 2 len = 3 ).
    out->write( lv_resulta ).




  ENDMETHOD.


ENDCLASS.
