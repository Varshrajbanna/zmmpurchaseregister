@AbapCatalog.sqlViewName: 'YINTR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Job Receipt Register Report'
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view ZMM_JOB_REC_REG_INTERNALID_1 as select from ZMM_JOB_REC_REG_CDS_INTERNALID
{
 
   key ClfnObjectInternalID,
   key ClfnObjectID,
   ClfnObjectTable,
   ClassType,
    '' as Lotnumber,
    '' as Milname
    
    
      
   
} 
