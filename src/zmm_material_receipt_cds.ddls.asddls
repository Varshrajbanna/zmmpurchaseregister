@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Material Receipt report'
define root view entity ZMM_MATERIAL_RECEIPT_CDS as select from YPURREGY_GRN_DATA as a 
     left outer join I_PurchaseOrderItemAPI01 as c on ( c.PurchaseOrder = a.PurchaseOrder 
                                                                   and c.PurchaseOrderItem = a.PurchaseOrderItem )  
     left outer join I_PurchaseOrderAPI01 as d on ( d.PurchaseOrder = a.PurchaseOrder )  
     left outer join I_PurOrdScheduleLineAPI01 as w on ( w.PurchaseOrder = c.PurchaseOrder and w.PurchaseOrderItem = c.PurchaseOrderItem )
     left outer join ZI_SupplierInvoiceAPI01 as bb on ( ( bb.ReferenceDocument = a.MaterialDocument 
                                                         and bb.PurchaseOrder = a.PurchaseOrder
                                                         and bb.PurchaseOrderItem = a.PurchaseOrderItem
                                                         and bb.ReferenceDocumentItem = a.MaterialDocumentItem
                                                       ) ) 
     left outer join YPURREGY_SERVICE_DATA as VV on ( VV.PurchaseOrder = a.PurchaseOrder  and VV.PurchaseOrderItem = a.PurchaseOrderItem 
     and  bb.PurchasingHistoryDocument is null    
     and  VV.PurchasingHistoryDocument = a.MaterialDocument 
     and  VV.PurchasingHistoryDocumentItem = a.MaterialDocumentItem )                                                       
     left outer join ZI_SupplierInvoiceAPI01 as cc on  ( cc.ReferenceDocument = VV.ReferenceDocument 
                                                          and cc.ReferenceDocumentItem = VV.ReferenceDocumentItem
                                                          and cc.PurchaseOrder = VV.PurchaseOrder
                                                          and cc.PurchaseOrderItem = VV.PurchaseOrderItem
                                                          and bb.PurchasingHistoryDocument is null )  
                                                          
// I_MaterialDocumentHeader_2   as a 
//                     left outer join I_MaterialDocumentItem_2 as b on ( b.MaterialDocument = a.MaterialDocument and 
//                                                                      b.MaterialDocumentYear = a.MaterialDocumentYear )
//                                                                      
//                     left outer join I_Supplier as g on ( g.Supplier = b.Supplier)
//                     left outer join I_ProductDescription as h on ( h.Product = b.Material and h.Language = 'E')                                                 
//                     left outer join I_PurchaseOrderItemAPI01 as c on ( c.PurchaseOrder = b.PurchaseOrder 
//                                                                   and c.PurchaseOrderItem = b.PurchaseOrderItem )  
//                     left outer join I_PurchaseOrderAPI01 as d on ( d.PurchaseOrder = b.PurchaseOrder )
                     left outer join I_PurchaseRequisitionItemAPI01 as e on ( e.PurchaseRequisition = c.PurchaseRequisition 
                                                                       and  e.PurchaseRequisitionItem = c.PurchaseRequisitionItem )
////                     left outer join ZPP_GET_ENTRY_NO as f on ( f.ebeln = b.PurchaseOrder  and f.ebelp = b.PurchaseOrderItem and
////                        (f.invoice =  a.MaterialDocumentHeaderText)  )
//
//     left outer join I_PurOrdScheduleLineAPI01 as w on ( w.PurchaseOrder = c.PurchaseOrder and w.PurchaseOrderItem = c.PurchaseOrderItem )
//
//     left outer join ZI_SupplierInvoiceAPI01 as bb on ( ( bb.ReferenceDocument = b.MaterialDocument  and bb.ReferenceDocumentItem = b.MaterialDocumentItem  
//                                                       ) ) 
////     left outer join I_PurchaseOrderHistoryAPI01 as VV on ( VV.PurchaseOrder = b.PurchaseOrder  and VV.PurchaseOrderItem = b.PurchaseOrderItem and ( VV.PurchasingHistoryCategory = '0' or VV.PurchasingHistoryCategory = 'T') )                                                      
//     left outer join I_PurchaseOrderHistoryAPI01 as VV on ( VV.PurchaseOrder = b.PurchaseOrder  and VV.PurchaseOrderItem = b.PurchaseOrderItem and ( VV.PurchasingHistoryCategory = '0' ) )                                                      
//    left outer join ZI_SupplierInvoiceAPI01 as cc on  ( cc.ReferenceDocument = VV.PurchasingHistoryDocument  and cc.ReferenceDocumentItem = VV.PurchasingHistoryDocumentItem  
//                                                      and bb.PurchasingHistoryDocument is null ) 
//   left outer join I_PurOrdAccountAssignmentAPI01 as WBS on ( WBS.PurchaseOrder = c.PurchaseOrder 
//                                                                       and  WBS.PurchaseOrderItem = c.PurchaseOrderItem )

//   left outer join I_Product as Z on (Z.Product = b.Material )
   left outer join ZMAX_GATNO as xx on xx.Purchase_order = a.PurchaseOrder and xx.Purchase_order_ITEM = a.PurchaseOrderItem
   left outer join ZMM_LABOUR_CHARGE_ZWARRANTY as ZWARRANTY  on ZWARRANTY.Batch = a.Batch 

   
   
      
      
                                                   
{
    key a.MaterialDocument,
    key a.MaterialDocumentYear, 
 key case when bb.DocumentDate  is  initial or bb.DocumentDate is null then cc.DocumentDate
 else  bb.DocumentDate end as DocumentDate  ,
    key a.PostingDate,
        a.Plant,
        a.StorageLocation,
        a.Plant as ChmlPlant,
        a.StorageLocation as ChmlStorageLocation,
        a.ReferenceDocument ,
        a.PurchaseOrder,
        a.PurchaseOrderItem,
        w.ScheduleLineDeliveryDate,
        a.MaterialDocumentItem,  
        a.Material,
        case when d.PurchaseOrderType = 'ZSER' or d.PurchaseOrderType = 'ZCPD' then 
        c.PurchaseOrderItemText else a.ProductDescription end as ProductDescription,
        a.Batch,
        a.SalesOrder,
        a.SalesOrderItem,
//        b.Supplier,
        a.SupplierName,
        a.DebitCreditCode,
        a.GoodsMovementType,
        a.MaterialBaseUnit,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        a.QuantityInBaseUnit,       
        a.CompanyCodeCurrency,
        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
        a.TotalGoodsMvtAmtInCCCrcy,
        a.GoodsMovementRefDocType,
        a.GoodsMovementIsCancelled,
        c.BaseUnit,
        c.MaterialGroup,
        c.MaterialType,
        c.PurchaseRequisition,
        c.PurchaseRequisitionItem,
        c.AccountAssignmentCategory,
        c.DocumentCurrency,
        @Semantics.amount.currencyCode: 'DocumentCurrency'
        c.NetAmount,
        @Semantics.amount.currencyCode: 'DocumentCurrency'
        c.GrossAmount,
        @Semantics.quantity.unitOfMeasure: 'BaseUnit'
        c.OrderQuantity,
        @Semantics.amount.currencyCode: 'DocumentCurrency'
        c.NetPriceAmount,
        c.TaxCode,
        c.BR_NCM,
        c.PurchaseOrderItemCategory,
        d.PurchaseOrderDate,
        d.PurchaseOrderType,
        e.PurchaseRequisitionType,
        @Semantics.quantity.unitOfMeasure: 'BaseUnit'
        e.RequestedQuantity,
        e.PurReqCreationDate,
        w.ScheduleLineDeliveryDate as DeliveryDate,
         case when bb.PurchasingHistoryDocument is null then cc.PurchasingHistoryDocument 
         else bb.PurchasingHistoryDocument end as MIR7NO,
         case when bb.PurchasingHistoryDocument is null then cc.AccountingDocument 
         else bb.AccountingDocument end as AccountingDocument,
         case when bb.PurchasingHistoryDocument is null then cc.SupplierPostingLineItemText 
         else bb.SupplierPostingLineItemText end as ItemText,
          @Semantics.amount.currencyCode: 'DocumentCurrency'
         case when bb.PurchasingHistoryDocument is null then cc.InvoiceAmtInCoCodeCrcy 
         else bb.InvoiceAmtInCoCodeCrcy end
         as InvoiceValue,
         // f.GateInDate,  
         case when bb.PurchasingHistoryDocument is null then cc.SupplierInvoiceStatus  
         else bb.SupplierInvoiceStatus  end as InvoiceStatus,
          case when bb.PurchasingHistoryDocument is null then cc.PostingDate 
         else bb.PostingDate end as InvoicePostingDate,
          case when bb.PurchasingHistoryDocument is null then cc.SupplierInvoice 
         else bb.SupplierInvoice end as SupplierInvoice,
         case when a.Supplier is null then d.SupplyingPlant  else   a.Supplier
         end as  Supplier,
          @Semantics.amount.currencyCode: 'DocumentCurrency'
         bb.PurchaseOrderAmount,
         @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
         case when bb.PurchasingHistoryDocument is null then  cc.IGSTAmount
         else  bb.IGSTAmount end as AmountInCompanyCodeCurrency  ,
         @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
         case when bb.PurchasingHistoryDocument is null then cc.SGSTAmount
         else bb.SGSTAmount end as sgst,
         
        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
        case when bb.PurchasingHistoryDocument is null then cc.CGSTAmount
         else bb.CGSTAmount end as cgst,
//         xx.gateno,
//         xx.gate_date, 
//         xx.GATE_QTY,
//         xx.e_way_bill,
      case when bb.SupplierInvoiceIDByInvcgParty is null then cc.SupplierInvoiceIDByInvcgParty
      else bb.SupplierInvoiceIDByInvcgParty end as SupplierInvoiceIDByInvcgParty,
      
      a.ShelfLifeExpirationDate ,
      ZWARRANTY.ZWARRANTY_CharcFromDate
      
      
         
         
           
    
}

    group by        
    a.MaterialDocument,
     a.MaterialDocumentYear,
     bb.DocumentDate,
     a.TotalGoodsMvtAmtInCCCrcy,
     a.PostingDate,
        a.Plant,
        a.ReferenceDocument,
        a.QuantityInBaseUnit,
        a.StorageLocation,
        a.Plant ,
        a.CompanyCodeCurrency,
        a.StorageLocation ,
        a.GoodsMovementRefDocType,
        a.GoodsMovementIsCancelled,
        c.BaseUnit,
        c.MaterialGroup,
        cc.AccountingDocument ,
        bb.AccountingDocument ,
        c.MaterialType,
        c.PurchaseRequisition,
        c.PurchaseRequisitionItem,
        c.AccountAssignmentCategory,
        c.DocumentCurrency,
        a.PurchaseOrder,
        a.PurchaseOrderItem,
        w.ScheduleLineDeliveryDate,
        a.MaterialDocumentItem,  
        a.Material,
        a.ProductDescription,
        a.Batch,
        a.SalesOrder,
        a.SalesOrderItem,
        a.Supplier,
        a.SupplierName,
        d.SupplyingPlant,
        a.DebitCreditCode,
        a.GoodsMovementType,
        a.MaterialBaseUnit,
      c.NetAmount,
       c.GrossAmount,
       c.OrderQuantity,
        c.NetPriceAmount,
        c.TaxCode,
        c.BR_NCM,
        c.RequisitionerName,
        c.RequirementTracking,
        c.PurchaseOrderItemCategory,
        d.PurchaseOrderDate,
        d.PurchaseOrderType,
        e.PurchaseRequisitionType,
       e.RequestedQuantity,
        e.PurReqCreationDate,
        e.DeliveryDate,
          bb.PurchasingHistoryDocument ,
          cc.PurchasingHistoryDocument ,
          bb.SupplierPostingLineItemText ,
          cc.SupplierPostingLineItemText ,
          bb.InvoiceAmtInCoCodeCrcy ,
          cc.InvoiceAmtInCoCodeCrcy,
          bb.PurchasingHistoryDocument,
          bb.SupplierInvoiceStatus ,
          cc.SupplierInvoiceStatus ,
          bb.PostingDate ,
          cc.PostingDate ,
          bb.SupplierInvoice,
          cc.SupplierInvoice ,
          bb.IGSTAmount,
          cc.IGSTAmount,
          bb.SGSTAmount,
          cc.SGSTAmount,
          bb.CGSTAmount,
          cc.CGSTAmount,
//          xx.gateno,
//          xx.gate_date,
//          xx.GATE_QTY,
          bb.PurchaseOrderAmount,
          c.PurchaseOrderItemText,
          bb.SupplierInvoiceIDByInvcgParty ,
          cc.SupplierInvoiceIDByInvcgParty,
          cc.DocumentDate,
    a.ShelfLifeExpirationDate,
    ZWARRANTY.ZWARRANTY_CharcFromDate 
//    xx.e_way_bill 
             
