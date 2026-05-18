@AbapCatalog.sqlViewName: 'YSERVDATA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Purchase Register Report'
define view YPURREGY_SERVICE_DATA as select from I_PurchaseOrderHistoryAPI01 
{
    key PurchasingHistoryDocument,
    key PurchaseOrder,
    key PurchaseOrderItem,
        ReferenceDocument,
        PurchasingHistoryDocumentItem,
        ReferenceDocumentItem
    
} 
where PurchasingHistoryCategory = 'E'
group by 
     PurchasingHistoryDocument,
     PurchaseOrder,
     PurchaseOrderItem,
     ReferenceDocument,
     PurchasingHistoryDocumentItem,
     ReferenceDocumentItem
