CLASS zmm_pr_report_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
*
*    INTERFACES if_oo_adt_classrun .

*****************creat vikram singh deora
    TYPES:BEGIN OF ty_final,
            pr                     TYPE i_purchaserequisitionitemapi01-purchaserequisition,
            orderedquantity        type i_purchaserequisitionitemapi01-OrderedQuantity,
            pritem                 TYPE i_purchaserequisitionitemapi01-purchaserequisitionitem,
            qty                    TYPE i_purchaserequisitionitemapi01-requestedquantity,
            pritemamount           TYPE i_purchaserequisitionitemapi01-itemnetamount,
            PurReqnItemCurrency    TYPE i_purchaserequisitionitemapi01-PurReqnItemCurrency,
            description            TYPE i_purchaserequisitionitemapi01-purchaserequisitionitemtext,
            plant                  TYPE i_purchaserequisitionitemapi01-plant,
            storagelocation        TYPE i_purchaserequisitionitemapi01-storagelocation,
            department             TYPE i_purchaserequisitionitemapi01-purchasinggroup,
            user1                  TYPE i_businessuserbasic-personfullname,
            remark                 TYPE i_purchaserequisitionitemapi01-yy1_remark1_pri,
            baseunit               TYPE i_purchaserequisitionitemapi01-baseunit,
            price                  TYPE i_purchaserequisitionitemapi01-purchaserequisitionprice,
            departmentname         TYPE i_purchasinggroup-purchasinggroupname,
            releaseedate           TYPE i_purchaserequisitionitemapi01-purchaserequisitionreleasedate,
            stutas                 TYPE i_purchaserequisitionitemapi01-processingstatus,
            deliverydate           TYPE i_purchaserequisitionitemapi01-deliverydate,
            item                   TYPE i_purchaserequisitionitemapi01-Material,
            Currentstock           TYPE I_MaterialStock_2-MatlWrhsStkQtyInMatlBaseUnit,
            CreationDate           TYPE i_purchaserequisitionitemapi01-CreationDate,
*            currentstock(10)          TYPE p DECIMALS 4,

          END OF ty_final.
    DATA:it_final TYPE TABLE OF ty_final,
         wa_final TYPE ty_final.

    INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZMM_PR_REPORT_CLASS IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

    DATA: lt_response TYPE TABLE OF zmm_pr_report_cds.
    DATA:lt_current_output TYPE TABLE OF zmm_pr_report_cds.
    DATA:wa1 TYPE zmm_pr_report_cds.

    DATA(lv_top)           = io_request->get_paging( )->get_page_size( ).
    DATA(lv_skip)          = io_request->get_paging( )->get_offset( ).
    DATA(lt_clause) = io_request->get_filter( )->get_as_sql_string( ).
    DATA(lt_filter)        = io_request->get_filter( )->get_as_sql_string( ).
    DATA(lt_fields)        = io_request->get_requested_elements( ).
    DATA(lt_sort)          = io_request->get_sort_elements( ).

    DATA(get_agge)         = io_request->get_aggregation(  ) .
    DATA(get_agge1)         = io_request->get_aggregation(  )->co_standard_aggregation_method .

    TRY.
        DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ).
      CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).
    ENDTRY.


    SELECT
             a~purchaserequisition,
             a~OrderedQuantity,
             a~purchaserequisitionitem,
             a~requestedquantity,
             a~itemnetamount,
             a~purchaserequisitionitemtext,
             a~plant,
             a~storagelocation,
             a~purchasinggroup,
             a~yy1_remark1_pri,
             a~baseunit,
             a~purchaserequisitionprice,
             a~purchaserequisitionreleasedate,
             a~processingstatus,
             a~deliverydate,
             a~PurReqnItemCurrency,
             b~personfullname,
             c~purchasinggroupname,
             a~material,
             a~CreationDate

*            d~MatlWrhsStkQtyInMatlBaseUnit
                            FROM i_purchaserequisitionitemapi01 AS a
                            LEFT JOIN i_businessuserbasic AS b ON ( b~UserID = a~createdbyuser )
                            LEFT JOIN i_purchasinggroup AS c ON ( c~purchasinggroup = a~purchasinggroup )
*                            LEFT JOIN I_MaterialStock_2 as d on ( d~Material = a~Material AND D~Plant = A~Plant )
                            WHERE a~IsDeleted = '' and a~AccountAssignmentCategory <> 'K'
                             AND   A~IsClosed = ''

                            INTO TABLE @DATA(i_data).



    SORT i_data BY purchaserequisition purchaserequisitionitem .
*    DELETE ADJACENT DUPLICATES FROM i_data COMPARING PurchaseRequisition PurchaseRequisitionItem Material purchaserequisitionitemtext MatlWrhsStkQtyInMatlBaseUnit  .

    LOOP AT i_data INTO DATA(w_data).

     MOVE-CORRESPONDING w_data TO wa_final.

      " Additional logic for status based on order quantity
   data aaa type string.

      if w_data-RequestedQuantity - w_data-orderedquantity <> 0 .


       aaa = 'N'.
*
       else.
    aaa = 'B'.

      ENDIF.




      wa_final-pr            = w_data-purchaserequisition.
      wa_final-pritem          = w_data-purchaserequisitionitem.
     wa_final-qty             = w_data-requestedquantity.
      wa_final-pritemamount    = w_data-itemnetamount.
      wa_final-PurReqnItemCurrency    = w_data-PurReqnItemCurrency.
      wa_final-description     = w_data-purchaserequisitionitemtext.
      wa_final-plant           = w_data-plant.
      wa_final-storagelocation = w_data-storagelocation.
      wa_final-department      = w_data-purchasinggroup.
      wa_final-user1            = w_data-personfullname.
      wa_final-remark          = w_data-yy1_remark1_pri.
      wa_final-baseunit        = w_data-baseunit.
      wa_final-price           = w_data-purchaserequisitionprice.
      wa_final-departmentname  = w_data-purchasinggroupname.
      wa_final-releaseedate    = w_data-purchaserequisitionreleasedate.
     wa_final-stutas          =  aaa .  "w_data-processingstatus.
      wa_final-deliverydate    = w_data-deliverydate.
      wa_final-item            = w_data-Material.
      wa_final-creationdate    = w_data-CreationDate.
*      wa_final-Currentstock    = w_data-MatlWrhsStkQtyInMatlBaseUnit.
      APPEND wa_final TO it_final.
      CLEAR:wa_final.

    ENDLOOP.

    MOVE-CORRESPONDING it_final TO lt_response..



    TRY.
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

        DATA(lv_offset) = io_request->get_paging( )->get_offset( ).
        DATA(lv_page_size) = io_request->get_paging( )->get_page_size( ).
        DATA(lv_max_rows) = COND #( WHEN lv_page_size = if_rap_query_paging=>page_size_unlimited
                                    THEN 0
                                    ELSE lv_page_size ).
        " sorting
        DATA(sort_elements) = io_request->get_sort_elements( ).
        DATA(lt_sort_criteria) = VALUE string_table(
            FOR sort_element IN sort_elements
            ( sort_element-element_name && COND #( WHEN sort_element-descending = abap_true
                                                   THEN ` descending`
                                                   ELSE ` ascending` ) ) ).

        DATA lv_sort_string TYPE string .
        lv_sort_string  = COND #( WHEN lt_sort_criteria IS INITIAL THEN '                                   '
                                                                            ELSE concat_lines_of( table = lt_sort_criteria sep = `, ` ) ).
        " requested elements
        DATA(lt_req_elements) = io_request->get_requested_elements( ).
        " aggregate
        DATA(lt_aggr_element) = io_request->get_aggregation( )->get_aggregated_elements( ).

        IF lt_aggr_element IS NOT INITIAL.
          LOOP AT lt_aggr_element ASSIGNING FIELD-SYMBOL(<fs_aggr_element>).
            DELETE lt_req_elements WHERE table_line = <fs_aggr_element>-result_element.
            DATA(lv_aggregation) = |{ <fs_aggr_element>-aggregation_method }( { <fs_aggr_element>-input_element } ) as { <fs_aggr_element>-result_element }|.
            APPEND lv_aggregation TO lt_req_elements.
          ENDLOOP.
        ENDIF.
        DATA(lv_req_elements) = concat_lines_of( table = lt_req_elements
                                                 sep   = `, ` ).
        " grouping
        DATA(lt_grouped_element) = io_request->get_aggregation( )->get_grouped_elements( ).
        DATA(lv_grouping) = concat_lines_of( table = lt_grouped_element
                                             sep   = `, ` ).


        IF lv_sort_string IS INITIAL.
          IF lv_grouping IS NOT INITIAL .
            lv_sort_string = lv_grouping .
          ELSE .
            lv_sort_string  = 'PLANT' .
          ENDIF .
        ENDIF .

        SELECT (lv_req_elements) FROM @lt_response AS a
                                            WHERE (lt_clause)
                                            GROUP BY (lv_grouping)
                                            ORDER BY (lv_sort_string)
                                            INTO CORRESPONDING FIELDS OF TABLE @lt_current_output
                                            OFFSET @lv_offset
                                             UP TO @lv_max_rows ROWS.

        IF io_request->is_total_numb_of_rec_requested(  ).
          io_response->set_total_number_of_records( lines( lt_response ) ).
        ENDIF.

        IF io_request->is_data_requested(  ).
          io_response->set_data( lt_current_output ).
        ENDIF.

      CATCH cx_root INTO DATA(lv_exception).

    ENDTRY.

  ENDMETHOD.
ENDCLASS.
