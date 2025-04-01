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

      out->write( lt_tree_parent ).

    ENDIF.

    DATA lc_var TYPE i VALUE 1.
      TRY.
        SELECT FROM HIERARCHY( SOURCE zahr_cds_aviation( pId = @lc_var )
         CHILD TO PARENT ASSOCIATION _Aviation
         START WHERE id = 1
      SIBLINGS ORDER BY id ASCENDING
         DEPTH 2
      MULTIPLE PARENTS ALLOWED
        CYCLES BREAKUP )
        FIELDS Id,
               ParentId,
               AviationName
          INTO TABLE @DATA(lt_result).


        IF lt_result IS NOT INITIAL.
          out->write( lt_result ).
        ENDIF.

      CATCH cx_sy_open_sql_db INTO DATA(lx_sql_db).
        out->write( lx_sql_db->get_text( ) ).
    ENDTRY.



  ENDMETHOD.

ENDCLASS.
