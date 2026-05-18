@AbapCatalog.sqlViewName: 'ZMAXGATNO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Register'
@Metadata.ignorePropagatedAnnotations: true
define view ZMAX_GATNO as select from ygateitem1 as a 
left outer join ygate1 as b on a.gateno = b.gateno
{
    key ebeln as Purchase_order ,
        ebelp as Purchase_order_ITEM,
        b.e_way_bill,
       max( a.gateno ) as gateno,
       max( b.entrydate ) as gate_date,
       sum(gatedoneqty) as GATE_QTY
}

group by 
ebeln,
ebelp,
    b.e_way_bill
