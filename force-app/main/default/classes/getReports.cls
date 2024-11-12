public with sharing class getReports implements Database.Batchable<Report>,Database.Stateful{
    public final String sObj;
    public final String fieldapi;
    public final String compType;
    public final Map<String, String>fullNameAndID = new Map<String, String>();
    public final String sessionIdd;
    public Integer cc;
    public final String OrgURL;
    // Get the report ID
    public getReports(String sessionid, String type,String Obj,String field){
        //system.debug(type);
        //system.debug(Obj);
        //system.debug(field);
        cc=0;
        //system.debug('sessionid::: '+sessionid);
        sessionIdd = sessionid;
        compType = type;
        sObj = Obj;
        fieldapi = field;       
    }    
    public Iterable<Report> start (Database.BatchableContext BC) {
        //system.debug(sObj);
        //system.debug(fieldapi);
        //Checking For Object and Field Level Security
        List <Report> reportList;
        if(
            Report.SObjectType.getDescribe().isAccessible() &&
            Schema.SObjectType.Report.fields.Id.isAccessible() &&
            Schema.SObjectType.Report.fields.DeveloperName.isAccessible()
        ){
            reportList = [SELECT Id,DeveloperName FROM Report Where Id != NULL LIMIT 50000];
        }
        //System.debug('Report List'+ reportList);
        //List <Report> reportList = [SELECT Id,DeveloperName FROM Report Where Id != NULL LIMIT 50000];
        Set<Id> reportIDSet = new Set<Id>();
        for(report rep: reportList){
            Reports.ReportResults results = Reports.ReportManager.runReport(rep.Id);
            Reports.ReportMetadata rm = results.getReportMetadata();
          //  system.debug(string.valueof(rm.getReportFilters()));
          //  system.debug(string.valueof(rm.getDetailColumns()));
          //  system.debug(string.valueof(rm.getBuckets()));
          //  system.debug(string.valueof(rm.getCustomSummaryFormula()));
          //  system.debug(string.valueof(rm.getAggregates()));
          //  system.debug(string.valueof(rm.getGroupingsDown()));
            if(string.valueof(rm.getReportFilters()).toLowerCase().contains((sObj+'.'+fieldapi).toLowerCase()) ||
               string.valueof(rm.getDetailColumns()).toLowerCase().contains((sObj+'.'+fieldapi).toLowerCase()) ||
               string.valueof(rm.getBuckets()).toLowerCase().contains((sObj+'.'+fieldapi).toLowerCase()) ||
               string.valueof(rm.getCustomSummaryFormula()).toLowerCase().contains((sObj+'.'+fieldapi).toLowerCase()) ||
               string.valueof(rm.getAggregates()).toLowerCase().contains((sObj+'.'+fieldapi).toLowerCase()) ||
               string.valueof(rm.getGroupingsDown()).toLowerCase().contains((sObj+'.'+fieldapi).toLowerCase()))
            {
                reportIDSet.add(rep.Id);
            }
        }
        /*for(integer i=0; i<scope.size();i++){
            String reportId = (String)scope.get(i).get('Id');
            
             
            
            // Run a report
            
            Reports.ReportResults results = Reports.ReportManager.runReport(reportId);
            
            
            // Get the report metadata
            
            Reports.ReportMetadata rm = results.getReportMetadata();
            
            System.debug('Name: ' + rm.getName());
            
            System.debug('ID: ' + rm.getId());
            
            System.debug('Currency code: ' + rm.getCurrencyCode());
            
            System.debug('Developer name: ' + rm.getDeveloperName());
            
             
            
            // Get grouping info for first grouping
            
            List<Reports.GroupingInfo> gInfo = rm.getGroupingsDown();
            if(ginfo != null && ginfo.size()>0){
                for(integer j = 0; j< ginfo.size(); j++){
                    System.debug('Grouping name: '+j+' ' + gInfo[j].getName());
                    
                    System.debug('Grouping sort order: '+j+' ' + gInfo[j].getSortOrder());
                    
                    System.debug('Grouping date granularity: '+j+' ' + gInfo[j].getDateGranularity());
                }
            }
        
        
            // Get aggregates
            
            System.debug('Aggregates: ' + rm.getAggregates());
            
            // Get Formulas
            System.debug('Formulas: ' + rm.getCustomSummaryFormula());
            
            // Get Buckets
            System.debug('Buckets: ' + rm.getBuckets());
            
            // Get detail columns
            
            System.debug('Detail columns: ' + rm.getDetailColumns());
            
            // Get report format
            
            System.debug('Report format: ' + rm.getReportFormat());
            
            // Get report filters
            system.debug('Filters: '+rm.getReportFilters());
            
            // get cross filters
            system.debug('cross filters: '+rm.getCrossFilters());            
        }*/
        //Checking For Object and Field Level Security
        List <Report> scope;
        if(
            Report.SObjectType.getDescribe().isAccessible() &&
            Schema.SObjectType.Report.fields.Id.isAccessible() &&
            Schema.SObjectType.Report.fields.DeveloperName.isAccessible()
        ){
            scope = [SELECT Id,DeveloperName FROM Report where ID IN: reportIDSet];
        }
        //List <Report> scope = [SELECT Id,DeveloperName FROM Report where ID IN: reportIDSet];
        return scope;
    }
    public void execute (Database.BatchableContext BC, List<Report> scope) {
        //system.debug(scope);
        //system.debug();
        Set<String> IdsSet = new Set<String>();
        for(Report rep: scope){
            IdsSet.add(rep.id+';'+rep.DeveloperName);
        }
        
        if(idsSet.size()>0){
            List<String> reportsIdsAndName= new List<String>(idsSet);
            List<Amanda__c> amList = new List<Amanda__c>();            
            String olds= '';
            String news = '';
            integer count = 0;
            for(Integer i = 0; i< reportsIdsAndName.size();i++){
                news = reportsIdsAndName[i]+','+olds;
                //System.debug('news###'+news);
                if(news.length() > 255){
                
                    Amanda__c am = new Amanda__c(name=String.valueOf(cc)+ String.valueOf(count)+'-'+'Flow');
                    if (Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isCreateable() && Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isAccessible()
                        && Schema.sObjectType.Amanda__c.fields.ComponentType__c.isCreateable() && Schema.sObjectType.Amanda__c.fields.ComponentType__c.isAccessible()){
                            am.ComponentIDs__c = olds;
                            am.ComponentType__c = 'Report';
                            olds = reportsIdsAndName[i];
                            news = '';
                            amList.add(am);
                            count = count + 1; 
                        }
                    
                }
                else if(news.length() == 255){
                    Amanda__c am = new Amanda__c(name= String.valueOf(cc)+String.valueOf(count)+'-'+'Flow');
                    if (Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isCreateable() && Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isAccessible()
                        && Schema.sObjectType.Amanda__c.fields.ComponentType__c.isCreateable() && Schema.sObjectType.Amanda__c.fields.ComponentType__c.isAccessible()){
                            am.ComponentIDs__c = news;
                            am.ComponentType__c = 'Report';
                            olds = '';
                            news = '';
                            amList.add(am);
                            count = count + 1; 
                        }
                    
                    
                    
                }else if(news.length() < 255){
                    if(i == reportsIdsAndName.size()-1 ){
                         Amanda__c am = new Amanda__c(name= String.valueOf(cc)+String.valueOf(count)+'-'+'Flow');
                        if (Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isCreateable() && Schema.sObjectType.Amanda__c.fields.ComponentIDs__c.isAccessible()
                            && Schema.sObjectType.Amanda__c.fields.ComponentType__c.isCreateable() && Schema.sObjectType.Amanda__c.fields.ComponentType__c.isAccessible()){
                                am.ComponentIDs__c = news;
                                am.ComponentType__c = 'Report';
                                olds = '';
                                news = '';
                                amList.add(am);
                            }
                        
                    
                        
                    }else
                    olds = news;
                }
                        
            }
            //System.debug('amList!!'+amList);
            if(Schema.sObjectType.Amanda__c.isCreateable()){
                insert amList;
            }
            
            amList.clear();
        }
    }
    public void finish (Database.BatchableContext BC) {
        //Do nothing
    }
}