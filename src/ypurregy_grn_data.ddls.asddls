@AbapCatalog.sqlViewName: 'YPUREGREPGRN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Purchase Register Report'
define view YPURREGY_GRN_DATA as select from I_MaterialDocumentHeader_2   as a 
                     left outer join I_MaterialDocumentItem_2 as b on ( b.MaterialDocument = a.MaterialDocument and 
                                                                      b.MaterialDocumentYear = a.MaterialDocumentYear )
                    left outer join I_Supplier as g on ( g.Supplier = b.Supplier) 
                    left outer join I_RegionText as REGO on ( REGO.Region = g.Region and REGO.Language = 'E' and REGO.Country = g.Country )
                     left outer join I_BusinessPartner as BusParnt on ( BusParnt.BusinessPartner = g.Supplier )
                     
                     left outer join I_ProductDescription as h on ( h.Product = b.Material and h.Language = 'E')  
                     left outer join I_Product as Z on (Z.Product = b.Material ) 
                     left outer join I_Plant as plant on ( plant.Plant = a.Plant and plant.Language = 'E' )                                               
{
    key a.MaterialDocument,
    key a.MaterialDocumentYear, 
    key a.DocumentDate,
    key a.PostingDate,
    key b.MaterialDocumentItem,
        a.Plant,
        a.StorageLocation,
        b.Plant as ChmlPlant,
        b.StorageLocation as ChmlStorageLocation,
       case when a.ReferenceDocument = '' then a.MaterialDocumentHeaderText else a.ReferenceDocument end as ReferenceDocument ,
        b.PurchaseOrder,
        b.PurchaseOrderItem, 
        b.Material,
        b.Batch,
        b.SalesOrder,
        b.SalesOrderItem,
        b.DebitCreditCode,
        b.GoodsMovementType,
        b.MaterialBaseUnit,
        b.Supplier,
        g.SupplierName,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        case when  b.DebitCreditCode = 'H' then
        sum( b.QuantityInBaseUnit ) * -1 else sum(b.QuantityInBaseUnit) end as QuantityInBaseUnit,       
        b.CompanyCodeCurrency,
        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
        case when  b.DebitCreditCode = 'H' then
        sum(b.TotalGoodsMvtAmtInCCCrcy) * -1 else sum(b.TotalGoodsMvtAmtInCCCrcy) end as TotalGoodsMvtAmtInCCCrcy,
        b.GoodsMovementRefDocType,
        b.GoodsMovementIsCancelled,
        g.TaxNumber3,
        g.PostalCode ,
        g.BPAddrCityName , 
        g.BPAddrStreetName ,
        REGO.RegionName   ,               
        BusParnt.BusinessPartnerGrouping ,
        h.ProductDescription,
        plant.PlantName,
        b.ShelfLifeExpirationDate
}
 where  b.GoodsMovementRefDocType = 'B'  and a.AccountingDocumentType = 'WE' and ( b.GoodsMovementType = '101' 
                                        or b.GoodsMovementType = '161' or b.GoodsMovementType = '122' )
           and b.GoodsMovementIsCancelled = ''
    group by        
     a.MaterialDocument,
     a.MaterialDocumentYear,
     a.DocumentDate,
     a.PostingDate,
        a.Plant,
        a.ReferenceDocument,
        a.MaterialDocumentHeaderText,
        a.StorageLocation,
        b.Plant ,
        b.CompanyCodeCurrency,
        b.StorageLocation ,
        b.GoodsMovementRefDocType,
        b.GoodsMovementIsCancelled,
        b.PurchaseOrder,
        b.PurchaseOrderItem,  
        b.Material,
        b.Batch,
        b.SalesOrder,
        b.SalesOrderItem,
        b.DebitCreditCode,
        b.GoodsMovementType,
        b.MaterialBaseUnit,
        b.Supplier,
        g.SupplierName,
        g.TaxNumber3,
        g.PostalCode ,
        g.BPAddrCityName , 
        g.BPAddrStreetName ,
        REGO.RegionName   ,               
        BusParnt.BusinessPartnerGrouping,
        h.ProductDescription,
        plant.PlantName,
        b.MaterialDocumentItem,
        b.ShelfLifeExpirationDate
