@AbapCatalog.sqlViewName: 'YSUPLIER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Supplier Invoice Report'
define view ZI_SupplierInvoiceAPI01 as select from I_JournalEntryItem as gg  
left outer join  I_OperationalAcctgDocItem as C on (C.AccountingDocument = gg.AccountingDocument and C.AccountingDocumentItem = gg.AccountingDocumentItem 
                                              and C.CompanyCode = gg.CompanyCode and C.FiscalYear = gg.FiscalYear )
left outer join I_SupplierInvoiceAPI01 as a on ( a.SupplierInvoiceWthnFiscalYear = C.OriginalReferenceDocument 
                                               and a.CompanyCode = C.CompanyCode )
                                               
inner join ZPurchaseOrderHistory_DATA as b on ( b.PurchasingHistoryDocument = gg.ReferenceDocument 
                                                and b.PurchasingHistoryDocumentItem = right(gg.ReferenceDocumentItem,4) 
                                                  )                                               
  left outer join I_OperationalAcctgDocItem as X on ( X.CompanyCode = C.CompanyCode // I_OperationalAcctgDocTaxItem
      and X.FiscalYear = C.FiscalYear    
      and X.AccountingDocument = C.AccountingDocument
      and X.OriginalReferenceDocument = a.SupplierInvoiceWthnFiscalYear 
      and X.TaxItemGroup = C.TaxItemGroup and X.TransactionTypeDetermination = 'JII' ) 
       
      left outer join I_OperationalAcctgDocItem as KK on ( KK.CompanyCode = C.CompanyCode
      and KK.FiscalYear = C.FiscalYear 
      and KK.AccountingDocument = C.AccountingDocument
      and KK.OriginalReferenceDocument = a.SupplierInvoiceWthnFiscalYear 
      and KK.TaxItemGroup = C.TaxItemGroup and KK.TransactionTypeDetermination = 'JIC' 
      ) 
      
       left outer join I_OperationalAcctgDocItem as YY on ( YY.CompanyCode = C.CompanyCode
      and YY.FiscalYear = C.FiscalYear 
      and YY.AccountingDocument = C.AccountingDocument
      and YY.OriginalReferenceDocument = a.SupplierInvoiceWthnFiscalYear 
      and YY.TaxItemGroup = C.TaxItemGroup and YY.TransactionTypeDetermination = 'JIS' )
           
                                                     
{   
    gg.AccountingDocument,
    b.ReferenceDocument,
    b.ReferenceDocumentItem,
    b.PurchasingHistoryDocument ,
    b.PurchasingHistoryDocumentItem ,
    b.InvoiceAmtInCoCodeCrcy ,
    a.SupplierInvoiceStatus ,
    a.CompanyCode,
    a.FiscalYear,
    a.PostingDate ,
    a.DocumentDate,
    a.SupplierInvoice,
    a.SupplierPostingLineItemText,
    C.PurchasingDocument as PurchaseOrder,
    C.PurchasingDocumentItem  as PurchaseOrderItem,
    a.SupplierInvoiceIDByInvcgParty,
    a.DocumentHeaderText,
    C.CompanyCodeCurrency,
   @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    sum(C.AmountInCompanyCodeCurrency ) as PurchaseOrderAmount,
    sum(X.AmountInCompanyCodeCurrency)      as IGSTAmount,
    sum(KK.AmountInCompanyCodeCurrency)     as CGSTAmount,
    sum(YY.AmountInCompanyCodeCurrency)     as SGSTAmount,
    b.TaxCode,
    a.SupplierInvoiceWthnFiscalYear,
    C.TaxItemGroup
    
}
 where // C.TransactionTypeDetermination = 'WRX' and 
 gg.SourceLedger = '0L'
 and gg.Ledger = '0L'
//   a.ReverseDocument = '' and a.ReverseDocumentFiscalYear = '0000'
//   and b.PurchasingHistoryCategory <> 'E'  and b.PurchasingHistoryCategory <> 'O'
   group by 
   gg.AccountingDocument,
    b.ReferenceDocument,
    b.ReferenceDocumentItem,
    b.PurchasingHistoryDocument ,
    b.PurchasingHistoryDocumentItem ,
    b.InvoiceAmtInCoCodeCrcy ,
    b.PurchasingHistoryDocument,
//    b.PurchaseOrderAmount,
    a.SupplierInvoiceStatus ,
    a.PostingDate ,
    a.DocumentDate,
    a.SupplierInvoice,
    a.CompanyCode,
    a.FiscalYear,
    a.SupplierPostingLineItemText,
    C.PurchasingDocument,
    C.PurchasingDocumentItem,
    a.SupplierInvoiceIDByInvcgParty,
    a.DocumentHeaderText,
    b.TaxCode,
    C.TaxItemGroup,
    a.SupplierInvoiceWthnFiscalYear,
    C.CompanyCodeCurrency
   
