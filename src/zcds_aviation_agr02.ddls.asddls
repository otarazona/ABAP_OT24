@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_ALLOWED
@EndUserText.label: 'Aviation CDS asociación jerárquica Agr02'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_AVIATION_AGR02
  with parameters
    pId : abap.int1
  as select from zavi_parent_ag02
  association [0..*] to ZCDS_AVIATION_AGR02 as _AVIATION on $projection.ParentId = _AVIATION.Id
{
  key id            as Id,
  key parent_id     as ParentId,
      aviation_name as AviationName,
      _AVIATION
}

where 

parent_id = $parameters.pId;
