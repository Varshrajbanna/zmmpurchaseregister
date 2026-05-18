@AbapCatalog.sqlViewName: 'YDGDFSDFD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MIR7 DATA'
@Metadata.ignorePropagatedAnnotations: true
define view ZMIR7_DATA as select from I_PurchaseOrderItemAPI01 as A
left outer join I_PurchaseOrderHistoryAPI01 as B on (A.PurchaseOrder = B.PurchaseOrder and  A.PurchaseOrderItem = B.PurchaseOrderItem )
left outer join I_SupplierInvoiceAPI01 as C on ( B.PurchasingHistoryDocument = C.SupplierInvoice )
{
    key A.PurchaseOrder,
    key A.PurchaseOrderItem,
    key B.PurchasingHistoryDocument,
    key B.PurchasingHistoryDocumentItem,
    key B.PurchasingHistoryCategory,
        C.SupplierInvoice,
        C.PostingDate,
        C.DocumentDate,
        C.SupplierInvoiceIDByInvcgParty,
        C.SupplierInvoiceStatus
        
        
    
}
where B.PurchasingHistoryCategory = 'T'
