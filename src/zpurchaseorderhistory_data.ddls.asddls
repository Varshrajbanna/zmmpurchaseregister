@AbapCatalog.sqlViewName: 'YPURCHASREHES'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For PurchaseOrderHistoryAPI01 Data'
define view ZPurchaseOrderHistory_DATA as select from I_PurchaseOrderHistoryAPI01 as a
left outer join I_SupplierInvoiceAPI01 as b on b.SupplierInvoice = a.PurchasingHistoryDocument and b.FiscalYear = a.PurchasingHistoryDocumentYear
{
    key a.PurchasingHistoryDocument,
    key a.PurchasingHistoryDocumentItem,
    key a.ReferenceDocument,
    key a.ReferenceDocumentItem,
    key a.PurchaseOrder,
    key a.ReferenceDocumentFiscalYear,
       a.PurchasingHistoryDocumentType ,
        sum(a.InvoiceAmtInCoCodeCrcy) as  InvoiceAmtInCoCodeCrcy,
        a.TaxCode
} 
     where  
       a.PurchasingHistoryCategory <> 'E' 
       and b.ReverseDocument = ''
       // and  PurchasingHistoryCategory <> 'O'
//      ( PurchasingHistoryCategory = 'Q' 
//   or
//   PurchasingHistoryCategory = 'G'
//   or
//   PurchasingHistoryCategory = 'N' )
group by 
      a.PurchasingHistoryDocument,
      a.PurchasingHistoryDocumentItem,
      a.ReferenceDocument,
      a.ReferenceDocumentItem,
      a.PurchaseOrder,
      a.ReferenceDocumentFiscalYear,
      a.PurchasingHistoryDocumentType,
      a.TaxCode
