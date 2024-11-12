public with sharing class JsonResponse_x{
    public cls_attributes attributes;
    public String Id;   //30170000000KzhzAAC
    public String DefinitionId; //30070000000TPv3AAG
    public String MasterLabel;  //Contact Form Sample
    public Integer VersionNumber;   //1
    public String Status;   //Active
    public String Description;  //The Contact form flow captures Contact Information such as Name and Email Address. It then lookup your salesforce if the Contact already exists and creates one if no contacts are found.
    public String ProcessType;
    public String CreatedDate;  //2013-08-09T22:00:09.000+0000
    public String CreatedById;  //005700000013HR3AAM
    public String LastModifiedDate; //2013-08-09T22:00:12.000+0000
    public String LastModifiedById; //005700000013HR3AAM
    public cls_Metadata Metadata;
    public String FullName; //Contact_Form-1
    public class cls_attributes {
        public String type; //Flow
        public String url;  ///services/data/v34.0/tooling/sobjects/Flow/30170000000KzhzAAC
    }
    /*public class cls_ProcessType {
        public String type='FLow';
    }*/
    public class cls_Metadata {    
        public String fullName;
        public FlowActionCall[] actionCalls;
        public FlowApexPluginCall[] apexPluginCalls;
        public FlowAssignment[] assignments;
        public FlowChoice[] choices;
        public FlowConstant[] constants;
        public FlowDecision[] decisions;
        public String description;
        public FlowDynamicChoiceSet[] dynamicChoiceSets;
        public FlowFormula[] formulas;
        public String label;
        public FlowLoop[] loops;
        public FlowMetadataValue[] processMetadataValues;
        public String processType;
        public FlowRecordCreate[] recordCreates;
        public FlowRecordDelete[] recordDeletes;
        public FlowRecordLookup[] recordLookups;
        public FlowRecordUpdate[] recordUpdates;
        public FlowScreen[] screens;
        public String startElementReference;
        public FlowStep[] steps;
        public FlowSubflow[] subflows;
        public FlowTextTemplate[] textTemplates;
        public FlowVariable[] variables;
        public FlowWait[] waits;
    }
    public class FlowActionCall {
        public String actionName;
        public String actionType;
        public FlowConnector connector;
        public FlowConnector faultConnector;
        public FlowActionCallInputParameter[] inputParameters;
        public FlowActionCallOutputParameter[] outputParameters;
    }
    public class FlowConnector {
        public String targetReference;
        private String[] targetReference_type_info = new String[]{'targetReference','http://soap.sforce.com/2006/04/metadata',null,'1','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/2006/04/metadata','true','false'};
        private String[] field_order_type_info = new String[]{'targetReference'};
    }
    public class FlowActionCallInputParameter {
        public String name;
        public FlowElementReferenceOrValue value;
    }
    public class FlowActionCallOutputParameter {
            public String assignToReference;
            public String name;
    }
    public class FlowElementReferenceOrValue {
            public Boolean booleanValue;
            public DateTime dateTimeValue;
            public Date dateValue;
            public String elementReference;
            public Double numberValue;
            public String stringValue;
    }       
    public class FlowApexPluginCall {
        public String apexClass;
        public FlowConnector connector;
        public FlowConnector faultConnector;
        public FlowApexPluginCallInputParameter[] inputParameters;
        public FlowApexPluginCallOutputParameter[] outputParameters;
    }
    public class FlowApexPluginCallInputParameter {
        public String name;
        public FlowElementReferenceOrValue value;
        private String[] name_type_info = new String[]{'name','http://soap.sforce.com/2006/04/metadata',null,'1','1','false'};
        private String[] value_type_info = new String[]{'value','http://soap.sforce.com/2006/04/metadata',null,'0','1','false'};
        private String[] apex_schema_type_info = new String[]{'http://soap.sforce.com/2006/04/metadata','true','false'};
        private String[] field_order_type_info = new String[]{'name','value'};
    }
    public class FlowApexPluginCallOutputParameter {
        public String assignToReference;
        public String name;
    }
        
    public class FlowAssignment {
        public FlowAssignmentItem[] assignmentItems;
        public FlowConnector connector;
    }
    public class FlowChoiceUserInput {
            public Boolean isRequired;
            public String promptText;
            public FlowInputValidationRule validationRule;
    }
    public class FlowInputValidationRule {
        public String errorMessage;
        public String formulaExpression;
    }
    public class FlowAssignmentItem {
        public String assignToReference;
        public String operator;
    }
    public class FlowChoice {
        public String choiceText;
        public String dataType;
        public FlowChoiceUserInput userInput;
        public FlowElementReferenceOrValue value;
        
    }
    public class FlowDecision {
        public FlowConnector defaultConnector;
        public String defaultConnectorLabel;
        public FlowRule[] rules;
    }
    public class FlowRule {
        public String conditionLogic;
        public FlowCondition[] conditions;
        public FlowConnector connector;
        public String label;
    }
    public class FlowCondition {
            public String leftValueReference;
            public String operator;
    }

    public class FlowConstant {
        public String dataType;
        public FlowElementReferenceOrValue value;
    }
    public class FlowDynamicChoiceSet {
        public String dataType;
        public String displayField;
        public FlowRecordFilter[] filters;
        public Integer limit_x;
        public String object_x;
        public FlowOutputFieldAssignment[] outputAssignments;
        public String sortField;
        public String sortOrder;
        public String valueField;
    }
    public class FlowRecordFilter {
        public String field;
        public String operator;
        public FlowElementReferenceOrValue value;
    }
    public class FlowOutputFieldAssignment {
            public String assignToReference;
            public String field;
    }
    public class FlowFormula {
        public String dataType;
        public String expression;
        public Integer scale;
    }
    public class FlowLoop {
        public String assignNextValueToReference;
        public String collectionReference;
        public String iterationOrder;
        public FlowConnector nextValueConnector;
        public FlowConnector noMoreValuesConnector;
    }
    public class FlowMetadataValue {
        public String name;
        public FlowElementReferenceOrValue value;
    }
    public class FlowRecordCreate {
        public String assignRecordIdToReference;
        public FlowConnector connector;
        public FlowConnector faultConnector;
        public FlowInputFieldAssignment[] inputAssignments;
        public String inputReference;
        public String object_x;
    }
    public class FlowInputFieldAssignment {
        public String field;
        public FlowElementReferenceOrValue value;
            
    }
    public class FlowRecordDelete {
        public FlowConnector connector;
        public FlowConnector faultConnector;
        public FlowRecordFilter[] filters;
        public String inputReference;
        public String object_x;
    }
    public class FlowRecordLookup {
        public Boolean assignNullValuesIfNoRecordsFound;
        public FlowConnector connector;
        public FlowConnector faultConnector;
        public FlowRecordFilter[] filters;
        public String object_x;
        public FlowOutputFieldAssignment[] outputAssignments;
        public String outputReference;
        public String[] queriedFields;
        public String sortField;
        public String sortOrder;
    }
    public class FlowRecordUpdate {
        public FlowConnector connector;
        public FlowConnector faultConnector;
        public FlowRecordFilter[] filters;
        public FlowInputFieldAssignment[] inputAssignments;
        public String inputReference;
        public String object_x;
    }
    public class FlowScreen {
        public Boolean allowBack;
        public Boolean allowFinish;
        public FlowConnector connector;
        public FlowScreenField[] fields;
        public String helpText;
    }
    public class FlowScreenField {
        public String[] choiceReferences;
        public String dataType;
        public String defaultSelectedChoiceReference;
        public FlowElementReferenceOrValue defaultValue;
        public String fieldText;
        public String fieldType;
        public String helpText;
        public Boolean isRequired;
        public Integer scale;
        public FlowInputValidationRule validationRule;
    }
    public class FlowStep {
        public FlowConnector[] connectors;
    }
    public class FlowSubflow {
        public FlowConnector connector;
        public String flowName;
        public FlowSubflowInputAssignment[] inputAssignments;
        public FlowSubflowOutputAssignment[] outputAssignments;
    }
    public class FlowSubflowInputAssignment {
        public String name;
        public MetadataService.FlowElementReferenceOrValue value;
    }
    public class FlowSubflowOutputAssignment {
        public String assignToReference;
        public String name;
    }   
    public class FlowTextTemplate {
        public String text;
    }
    public class FlowVariable {
        public String dataType;
        public Boolean isCollection;
        public Boolean isInput;
        public Boolean isOutput;
        public String objectType;
        public Integer scale;
        public FlowElementReferenceOrValue value;
    }
    public class FlowWait {
        public FlowConnector defaultConnector;
        public String defaultConnectorLabel;
        public FlowConnector faultConnector;
        public FlowWaitEvent[] waitEvents;
    }
    public class FlowWaitEvent {
        public String conditionLogic;
        public FlowCondition[] conditions;
        public FlowConnector connector;
        public String eventType;
        public FlowWaitEventInputParameter[] inputParameters;
        public String label;
        public FlowWaitEventOutputParameter[] outputParameters;
    }
    public class FlowWaitEventInputParameter {
        public String name;
        public FlowElementReferenceOrValue value;
    }
    public class FlowWaitEventOutputParameter {
        public String assignToReference;
        public String name;
    }
    public static jsonResponse_x parse(String json){
        return (jsonResponse_x) System.JSON.deserialize(json, jsonResponse_x.class);
    }
}