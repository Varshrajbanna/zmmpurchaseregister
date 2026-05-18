//@EndUserText.label: 'ZMM_PR_REPORT_CDS'
//@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'RESPONCE CDS'
@Metadata.allowExtensions: true

@ObjectModel: {
    query: {
        implementedBy: 'ABAP:ZMM_PR_REPORT_CLASS'
    }
}
define root custom entity ZMM_PR_REPORT_CDS 
{
    @UI.lineItem             : [{ position: 10 }]
      @EndUserText.label       : 'Purchase Requisition'
  key pr         : abap.char( 10 ) ;

      @UI.lineItem             : [{ position: 20 }]
      @EndUserText.label       : 'Purchase Requisition Item'
      @UI.selectionField       : [{position: 10}]
      @UI.identification       : [{position: 10}]
  key pritem        : abap.numc( 5 );
      
      @UI.lineItem             : [{ position: 30 }]
      @EndUserText.label       : 'Qty'
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
   key  qty         : abap.quan( 15, 3  );
      
      @UI.lineItem             : [{ position: 40 }]
      @EndUserText.label       : 'UOM'
  key    baseunit         : abap.unit( 3 );
      
      @UI.lineItem             : [{ position: 40 }]
      @EndUserText.label       : 'Currency'
  key   PurReqnItemCurrency      : abap.cuky( 5 );
      
      @UI.lineItem             : [{ position: 50 }]
      @Aggregation.default: #SUM
      @EndUserText.label       : 'Pr item amount'
      @Semantics.amount.currencyCode: 'PurReqnItemCurrency'
 key   pritemamount         :  abap.curr( 15, 2 ); 
      
       
      @UI.lineItem             : [{ position: 60 }]
      @EndUserText.label       : 'Item'
  key  item         : abap.char( 18 );         
      
      @UI.lineItem             : [{ position: 70 }]
      @EndUserText.label       : 'Description'
  key    description         : abap.char( 40 );
      
   
        @Semantics.unitOfMeasure: true
  key     MaterialBaseUnit         : abap.unit(3);  
//      MaterialBaseUnit     : abap.quan( 15, 3 );
      
      
//         @UI.lineItem             : [{ position: 80 }]
//      @EndUserText.label       : 'Current stock'
//       @Aggregation.default: #SUM
//      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
//   key   Currentstock         : abap.quan( 15,3 );
      
      
      
      @UI.lineItem             : [{ position: 90 }]
      @EndUserText.label       : 'Plant'
  key    plant         : abap.char( 4 );
      
      @UI.lineItem             : [{ position: 100 }]
      @EndUserText.label       : 'Storage Location'
 key     storagelocation         : abap.char( 4 );
      
      @UI.lineItem             : [{ position: 110 }]
      @EndUserText.label       : 'Department'
      department         : abap.char( 4 );
      
      @UI.lineItem             : [{ position: 120 }]
      @EndUserText.label       : 'Remark'
      remark         : abap.char( 100 );
      
      
      @UI.lineItem             : [{ position: 130 }]
      @EndUserText.label       : 'Price'
       @Semantics.amount.currencyCode: 'PurReqnItemCurrency'
      price         : abap.curr( 10, 2 );
      
      @UI.lineItem             : [{ position: 140 }]
      @EndUserText.label       : 'Release date'
      releaseedate         : abap.dats;
      
       @UI.lineItem             : [{ position: 150 }]
       @EndUserText.label       : 'Stutas'
       stutas         : abap.char( 10 );
      
       @UI.lineItem             : [{ position: 160 }]
       @EndUserText.label       : 'Delivery date'
       deliverydate         : abap.dats;
      
       @UI.lineItem             : [{ position: 170 }]
       @EndUserText.label       : 'User Name'
       user1         : abap.char( 40 );
      
       @UI.lineItem             : [{ position: 180 }]
       @EndUserText.label       : 'Department Name'
       departmentname         : abap.char( 20 );
       
        @UI.lineItem            : [{ position: 190 }]
       @EndUserText.label       : 'Pr Creation Date'
       creationdate             : abap.dats;
       
       
        
      
      
      
}
