@AbapCatalog.sqlViewName: 'YINTERNALID'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Job Receipt Register Report'
define view ZMM_JOB_REC_REG_CDS_INTERNALID as select from 
           I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  )
{
   key $session.user as CLIENT,
   key ClfnObjectInternalID,
   key ClfnObjectID,
       ClfnObjectTable,
       ClassType
       
   
} 
