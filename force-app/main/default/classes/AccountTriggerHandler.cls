public with sharing class AccountTriggerHandler extends TriggerHandler {
    private List<Account> newAccList;
    private Map<Id, Account> newAccMap;
    private List<Account> oldAccList;
    private Map<Id, Account> oldAccMap;

    public AccountTriggerHandler() {
        this.newAccList = (List<Account>) Trigger.new;
        this.newAccMap = (Map<Id, Account>) Trigger.newMap;
        this.oldAccList = (List<Account>) Trigger.old;
        this.oldAccMap = (Map<Id, Account>) Trigger.oldMap;
    }

    //Override virtual methods
    public override void beforeInsert() {
        // Referencing setTypeProspect Helper method
        AccountHelper.setTypeProspect(newAccList);

        // Referencing addressCopy Helper method
        AccountHelper.addressCopy(newAccList);
        
        // Referencing setRating Helper method
        AccountHelper.setRating(newAccList);
    }

    public override void afterInsert() {
        // Referencing defaultContact Helper
        AccountHelper.defaultContact(newAccList);
    }

}