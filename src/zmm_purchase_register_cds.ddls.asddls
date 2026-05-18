@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Purchase Reqister Report'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
//   @UI.presentationVariant: [{ 
//      //         sortOrder: [{ by: '' }],
//                  groupBy: [ '' ],
//                   visualizations: [{ type: #AS_LINEITEM }] ,
//                   requestAtLeast: [ '' ]}]
define root view entity ZMM_PURCHASE_REGISTER_CDS as select from ZMM_MATERIAL_RECEIPT_CDS as A
left outer join ZMIR7_DATA as B on ( B.PurchaseOrder = A.PurchaseOrder and B.PurchaseOrderItem = A.PurchaseOrderItem  ) 



{    

    @UI.lineItem   : [{ position: 280 }]
    @UI.identification: [{position: 280}]
    @EndUserText.label: 'MaterialDocument' 
    @UI.selectionField: [{ position: 10 }]
     @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_MaterialDocumentHeader_2',
                     element: 'MaterialDocument' }
        }] 
      
    key A.MaterialDocument,
    @UI.lineItem   : [{ position: 290 }]
    @UI.identification: [{position: 290}]
    @EndUserText.label: 'MaterialDocumentYear' 
    key A.MaterialDocumentYear,
    @UI.lineItem   : [{ position: 300 }]
    @UI.identification: [{position: 300}]
    @EndUserText.label: 'DocumentDate' 
    key A.DocumentDate,
    @UI.lineItem   : [{ position: 310 }]
    @UI.identification: [{position: 310}]
    @EndUserText.label: 'PostingDate' 
    @UI.selectionField: [{ position: 20 }]
    key A.PostingDate,
    @UI.lineItem   : [{ position: 10 }]
    @UI.identification: [{position: 10}]
    @EndUserText.label: 'PurchaseRequisition' 
    key A.PurchaseRequisition,   
    @UI.lineItem   : [{ position: 20 }]
    @UI.identification: [{position: 20}]
    @EndUserText.label: 'PurchaseRequisitionItem' 
    key A.PurchaseRequisitionItem,
    @UI.lineItem   : [{ position: 60 }]
    @UI.identification: [{position: 60}]
    @EndUserText.label: 'PurchaseOrder' 
    @UI.selectionField: [{ position: 30 }]
     @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_PurchaseOrderAPI01',
                     element: 'PurchaseOrder' }
        }] 
    key A.PurchaseOrder,
    @UI.lineItem   : [{ position: 70 }]
    @UI.identification: [{position: 70}]
    @EndUserText.label: 'PurchaseOrderItem' 
    key A.PurchaseOrderItem,
    @UI.lineItem   : [{ position: 370 }]
    @UI.identification: [{position: 370}]
    @EndUserText.label: 'MIR7NO' 
    @UI.selectionField: [{ position: 50 }]
   key case when  A.MIR7NO is null then  B.SupplierInvoice  else  A.MIR7NO
   end as   MIR7NO
    ,
    @UI.lineItem   : [{ position: 250 }]
    @UI.identification: [{position: 250}]
    @EndUserText.label: 'Batch' 
    key A.Batch ,
    @UI.lineItem   : [{ position: 210 }]
    @UI.identification: [{position: 210}]
    @EndUserText.label: 'Material' 
    key A.Material,
    @UI.lineItem   : [{ position: 30 }]
    @UI.identification: [{position: 30}]
    @EndUserText.label: 'PurchaseRequisitionType' 
  key  A.PurchaseRequisitionType,
    @UI.lineItem   : [{ position: 40 }]
    @UI.identification: [{position: 40}]
    @EndUserText.label: 'PurReqCreationDate'
   key A.PurReqCreationDate,
     @UI.lineItem   : [{ position: 50 }]
    @UI.identification: [{position: 50}]
    @EndUserText.label: 'PR Quantity' 
    @Aggregation.default: #SUM
//    @Semantics.quantity.unitOfMeasure: 'Base
   key cast ( A.RequestedQuantity as abap.dec( 23,3 )) as RequestedQuantity,
    
//     @UI.lineItem   : [{ position: 80 }]
 //   @UI.identification: [{position: 80}]
//    @EndUserText.label: 'PurchaseOrderItemCategory' 
//    PurchaseOrderItemCategory,
//    @UI.lineItem   : [{ position: 90 }]
//    @UI.identification: [{position: 90}]
//    @EndUserText.label: 'AccountAssignmentCategory' 
//    AccountAssignmentCategory,
    @UI.lineItem   : [{ position: 100 }]
    @UI.identification: [{position: 100}]
    @EndUserText.label: 'PurchaseOrderDate' 
  key  A.PurchaseOrderDate,
     @UI.lineItem   : [{ position: 110 }]
    @UI.identification: [{position: 110}]
    @EndUserText.label: 'PurchaseOrderType' 
   key A.PurchaseOrderType,
    @UI.lineItem   : [{ position: 120 }]
    @UI.identification: [{position: 120}]
    @EndUserText.label: 'DeliveryDate' 
  key  A.DeliveryDate,
    @UI.lineItem   : [{ position: 130 }]
    @UI.identification: [{position: 130}]
    @EndUserText.label: 'OrderQuantity' 
    @Aggregation.default: #SUM
//    @Semantics.quantity.unitOfMeasure: 'BaseUnit'
    
  key  cast ( A.OrderQuantity as abap.dec( 23,3 )) as OrderQuantity,
//    OrderQuantity,
    @UI.lineItem   : [{ position: 140 }]
    @UI.identification: [{position: 140}]
    @EndUserText.label: 'DocumentCurrency' 
  key  A.DocumentCurrency,
    @UI.lineItem   : [{ position: 150 }]
    @UI.identification: [{position: 150}]
    @EndUserText.label: 'NetAmount' 
    @Aggregation.default: #SUM
//    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
 key    cast ( A.NetAmount as abap.dec( 23,2 )) as NetAmount,
//    NetAmount,
    @UI.lineItem   : [{ position: 160 }]
    @UI.identification: [{position: 160}]
    @EndUserText.label: 'GrossAmount' 
    @Aggregation.default: #SUM
//    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
 key      cast ( A.GrossAmount as abap.dec( 23,2 )) as GrossAmount,
//    GrossAmount,
    @UI.lineItem   : [{ position: 170 }]
    @UI.identification: [{position: 170}]
    @EndUserText.label: 'NetPriceAmount' 
    @Aggregation.default: #SUM
//    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
 key     cast ( A.NetPriceAmount as abap.dec( 23,2 )) as NetPriceAmount,
//    NetPriceAmount, 
    @UI.lineItem   : [{ position: 180 }]
    @UI.identification: [{position: 180}]
    @EndUserText.label: 'Plant' 
 key   A.Plant,
    @UI.lineItem   : [{ position: 190 }]
    @UI.identification: [{position: 190}]
    @EndUserText.label: 'StorageLocation' 
 key   A.StorageLocation,   
    @UI.lineItem   : [{ position: 200 }]
    @UI.identification: [{position: 200}]
    @EndUserText.label: 'Delivery Note'
  key  A.ReferenceDocument,
    @UI.lineItem   : [{ position: 220 }]
    @UI.identification: [{position: 220}]
    @EndUserText.label: 'ProductDescription'
 key   A.ProductDescription,
    @UI.lineItem   : [{ position: 230 }]
    @UI.identification: [{position: 230}]
    @EndUserText.label: 'MaterialGroup' 
 key   A.MaterialGroup,
    @UI.lineItem   : [{ position: 240 }]
    @UI.identification: [{position: 240}]
    @EndUserText.label: 'MaterialType' 
 key   A.MaterialType,   
    @UI.lineItem   : [{ position: 260 }]
    @UI.identification: [{position: 260}]
    @EndUserText.label: 'Supplier' 
    @UI.selectionField: [{ position: 40 }]
    @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_Supplier',
                     element: 'Supplier' }
        }] 
 key   A.Supplier,
    @UI.lineItem   : [{ position: 270 }]
    @UI.identification: [{position: 270}]
    @EndUserText.label: 'SupplierName' 
  key  A.SupplierName,    
    @UI.lineItem   : [{ position: 320 }]
    @UI.identification: [{position: 320}]
    @EndUserText.label: 'MaterialBaseUnit' 
  key  A.MaterialBaseUnit,
    @UI.lineItem   : [{ position: 330 }]
    @UI.identification: [{position: 330}]
    @EndUserText.label: ' GRN Quantity'
    @Aggregation.default: #SUM
//    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
key      cast ( A.QuantityInBaseUnit as abap.dec( 23,3 )) as QuantityInBaseUnit, 
//    QuantityInBaseUnit,
    @UI.lineItem   : [{ position: 340 }]
    @UI.identification: [{position: 340}]
    @EndUserText.label: 'GRN Amount' 
    @Aggregation.default: #SUM
  key  cast ( A.TotalGoodsMvtAmtInCCCrcy as abap.dec( 23,2 )) as TotalGoodsMvtAmtInCCCrcy, 
//    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
//    TotalGoodsMvtAmtInCCCrcy,
//    @UI.lineItem   : [{ position: 350 }]
//    @UI.identification: [{position: 350}]
//    @EndUserText.label: 'GoodsMovementRefDocType' 
//    GoodsMovementRefDocType,
    @UI.lineItem   : [{ position: 360 }]
    @UI.identification: [{position: 360}]
    @EndUserText.label: 'BaseUnit' 
key    A.BaseUnit, 
    @UI.lineItem   : [{ position: 380 , criticality: 'AmountInCompanyCodeCurrency' }]
    @UI.identification: [{position: 380}]
    @EndUserText.label: 'InvoiceStatus' 
//    InvoiceStatus,
key   case when A.InvoiceStatus = 'A' then 'Park' when A.InvoiceStatus = '5' then 'Post' 
   when A.InvoiceStatus = 'B' then 'Completed' 
   when A.InvoiceStatus is initial or A.InvoiceStatus is null then
      case when B.SupplierInvoiceStatus = 'A' then 'Park' when B.SupplierInvoiceStatus = '5' then 'Post' 
      when B.SupplierInvoiceStatus = 'B' then 'Completed'  else B.SupplierInvoiceStatus end 
   else A.InvoiceStatus end as PriceListType,  
//    @UI.lineItem   : [{ position: 390 }]
//    @UI.identification: [{position: 390}]
//    @EndUserText.label: 'ItemText' 
//    ItemText,
    @UI.lineItem   : [{ position: 400 }]
    @UI.identification: [{position: 400}]
    @EndUserText.label: 'InvoicePostingDate' 
    @UI.selectionField: [{ position: 60 }]
 key case when  A.InvoicePostingDate is initial or  A.InvoicePostingDate is null  then B.PostingDate
  else A.InvoicePostingDate end as  InvoicePostingDate   ,
   @UI.lineItem   : [{ position: 410 }]
    @UI.identification: [{position: 410}]
    @EndUserText.label: 'Taxable Value' 
    @Aggregation.default: #SUM
//    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
 key     cast ( A.PurchaseOrderAmount as abap.dec( 23,2 )) as PurchaseOrderAmount,
//    PurchaseOrderAmount,
//    @UI.lineItem   : [{ position: 420 }]
//    @UI.identification: [{position: 420}]
//    @EndUserText.label: 'SupplierInvoice' 
//    SupplierInvoice,
    @UI.lineItem   : [{ position: 430 }]
    @UI.identification: [{position: 430}]
    @EndUserText.label: 'Company Code Currency' 
key    A.CompanyCodeCurrency,
//    @UI.lineItem   : [{ position: 440 }]
//    @UI.identification: [{position: 440}]
//    @EndUserText.label: 'WBS Element' 
//    @UI.selectionField: [{ position: 50 }]
//     @Consumption.valueHelpDefinition: [ 
//        { entity:  { name:    'ZWBSELEMENT_F4',
//                     element: 'WBSElement' }
//        }] 
//    cast(WBSElementInternalID as abap.char( 24 ) ) as WBSElementInternalID,
//    
//      @UI.lineItem   : [{ position: 450 }]
//    @UI.identification: [{position: 450}]
//    @EndUserText.label: 'Long Description'
//    
//    YY1_MaterialLongDescri_PRD ,
    
       @UI.lineItem   : [{ position: 451 }]
    @UI.identification: [{position: 451}]
    @EndUserText.label: 'IGST'
    @Aggregation.default: #SUM
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
 key  cast(A.AmountInCompanyCodeCurrency as  abap.dec( 23, 2 ) ) as AmountInCompanyCodeCurrency,
   
    
     @UI.lineItem   : [{ position: 452 }]
    @UI.identification: [{position: 452}]
    @EndUserText.label: 'CGST'
    @Aggregation.default: #SUM
 key  cast(A.cgst as  abap.dec( 23, 2 ) ) as cgst,
   
    @UI.lineItem   : [{ position: 455 }]
    @UI.identification: [{position: 455}]
    @EndUserText.label: 'SGST'
    @Aggregation.default: #SUM
 key  cast(A.sgst as  abap.dec( 23, 2 ) ) as sgst,
  
//    @UI.lineItem   : [{ position: 457 }]
//    @UI.identification: [{position: 457}]
//    @EndUserText.label: 'Gate Entry No'
//  key  A.gateno,
//    
//    @UI.lineItem   : [{ position: 458 }]
//    @UI.identification: [{position: 458 }]
//    @EndUserText.label: 'Gate Entry Date'
//  key  A.gate_date,
//   
//    @UI.lineItem   : [{ position: 459 }]
//    @UI.identification: [{position: 459}]
//    @EndUserText.label: 'Gate Quantity'
//    @Aggregation.default: #SUM
//  key  A.GATE_QTY,
    
    
   
    @UI.lineItem   : [{ position: 460 }]
    @UI.identification: [{position: 460}]
    @EndUserText.label: 'Total Invoice Value '
    @Aggregation.default: #SUM

key  coalesce( cast(A.PurchaseOrderAmount as abap.dec( 16, 2 ) ) , 0 ) + coalesce( cast(A.cgst as abap.dec( 16, 2 ) ) , 0 ) +  
  coalesce( cast(A.sgst as abap.dec( 16, 2 ) ) , 0 ) +  coalesce( cast(A.AmountInCompanyCodeCurrency as abap.dec( 16, 2 ) ) , 0 )  as TotalInvoiceValue2,
  
  
      @UI.lineItem   : [{ position: 461 }]
    @UI.identification: [{position: 461 }]
    @EndUserText.label: 'Supplier Invoice'
key case when  A.SupplierInvoiceIDByInvcgParty  is initial or A.SupplierInvoiceIDByInvcgParty is null then B.SupplierInvoiceIDByInvcgParty 
else A.SupplierInvoiceIDByInvcgParty end as  SupplierInvoiceIDByInvcgParty ,
  
    @UI.lineItem   : [{ position: 462 }]
    @UI.identification: [{position: 462 }]   
    @EndUserText.label: 'Invoice Date' 
key  case when   A.DocumentDate  is initial or A.DocumentDate  is null then B.DocumentDate
  else A.DocumentDate end
   as alias1,
   
   
       @UI.lineItem   : [{ position: 463 }]
    @UI.identification: [{position: 463 }]   
    @EndUserText.label: 'Selflife date'
 key A.ShelfLifeExpirationDate ,
  
         @UI.lineItem   : [{ position: 464 }]
    @UI.identification: [{position: 464 }]   
    @EndUserText.label: 'Warranty information '
 key A.ZWARRANTY_CharcFromDate ,
  
//           @UI.lineItem   : [{ position: 465 }]
//    @UI.identification: [{position: 465 }]   
//    @EndUserText.label: 'eway bill'
// key A.e_way_bill,
 @UI.lineItem   : [{ position: 466 }]
    @UI.identification: [{position: 466 }]   
    @EndUserText.label: 'Accounting Document'
 key A.AccountingDocument 

    
} 

group by 
    A.MaterialDocument,
    A.MaterialDocumentYear,
//    WBSElementInternalID,
    A.DocumentDate,
    A.PostingDate,
    A.PurchaseRequisition,   
    A.PurchaseRequisitionItem,
    A.PurchaseRequisitionType,
    A.PurReqCreationDate,
    A.RequestedQuantity,
    A.PurchaseOrder,
    A.PurchaseOrderItem,
    A.PurchaseOrderItemCategory,
    A.AccountAssignmentCategory,
    A.PurchaseOrderDate,
    A.PurchaseOrderType,
    A.DeliveryDate,
    A.OrderQuantity,
    A.DocumentCurrency,
    A.NetAmount,
    A.GrossAmount,
    A.NetPriceAmount, 
    A.Plant,
    A.StorageLocation,   
    A.ReferenceDocument,
    A.Material,
    A.ProductDescription,
    A.MaterialGroup,
    A.MaterialType, 
    A.Batch,
    A.Supplier,
    A.SupplierName,    
    A.MaterialBaseUnit,
    A.QuantityInBaseUnit,
    A.TotalGoodsMvtAmtInCCCrcy,
    A.GoodsMovementRefDocType,
    A.BaseUnit, 
//    A.gateno, 
//    A.gate_date,
//    A.GATE_QTY, 
    A.MIR7NO,
    A.InvoiceStatus,
    A.ItemText,
    A.InvoicePostingDate,
    A.InvoiceValue,
    A.SupplierInvoice,
    A.CompanyCodeCurrency,
    A.PurchaseOrderAmount,
  //  YY1_MaterialLongDescri_PRD,
    A.AmountInCompanyCodeCurrency ,
    A.cgst,
    A.sgst,
    A.SupplierInvoiceIDByInvcgParty,
    B.SupplierInvoice ,
    B.SupplierInvoiceStatus,
    B.PostingDate,
    B.DocumentDate,
    B.SupplierInvoiceIDByInvcgParty,
    A.ShelfLifeExpirationDate,
    A.ZWARRANTY_CharcFromDate,
//    A.e_way_bill ,
    A.AccountingDocument
