public with sharing class OpportunityTriggerHandler extends TriggerHandler {
    private List<Opportunity> newOppList;
    private Map<Id, Opportunity> newOppMap;
    private List<Opportunity> oldOppList;
    private Map<Id, Opportunity> oldOppMap;
    
    public OpportunityTriggerHandler() {
        this.newOppList = (List<Opportunity>) Trigger.new;
        this.newOppMap = (Map<Id, Opportunity>) Trigger.newMap;
        this.oldOppList = (List<Opportunity>) Trigger.old;
        this.oldOppMap = (Map<Id, Opportunity>) Trigger.oldMap;
    }

// Override virtual methods in TriggerHandler
    public override void beforeUpdate() {
        // Reference OpportunityHelper amountValidation method
        OpportunityHelper.amountValidation(newOppList);

        // Reference OpportunityHelper setPrimaryContact method
        OpportunityHelper.setPrimaryContact(newOppList);
    }

    public override void beforeDelete() {
        // Reference OpportunityHelper deleteCloseWonOpportunity method
        OpportunityHelper.deleteCloseWonOpportunity(oldOppList);
    }

    public override void beforeInsert() {
        // Reference OpportunityHelper setType method
        OpportunityHelper.setType(newOppList);
    }

    public override void afterInsert() {
        // Reference OpportunityHelper insertTask method
        OpportunityHelper.insertTask(newOppList);
    }

    public override void afterUpdate() {
        // Reference OpportunityHelper updateDescriptionFromStage method
        OpportunityHelper.updateDescriptionFromStage(newOppList, oldOppMap);     
    }

    public override void afterDelete() {
        // Reference OpportunityHelper notifyOwnersOpportunityDeleted method
        OpportunityHelper.notifyOwnersOpportunityDeleted(oldOppList);
    }

    public override void afterUndelete() {
        // Reference OpportunityHelper assignPrimaryContact method
        OpportunityHelper.assignPrimaryContact(newOppMap);
    }
}