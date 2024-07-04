public with sharing class OpportunityHelper {
    
    public static void amountValidation (List<Opportunity> newOpps) {
        for(Opportunity opp : newOpps){
            if(opp.Amount < 5000){
                opp.addError('Opportunity amount must be greater than 5000');
            }
        }
    }

    public static void deleteCloseWonOpportunity (List<Opportunity> oldOpps) {
        //Account related to the opportunities 
        Map<Id, Account> accounts = new Map<Id, Account>([SELECT Id, Industry FROM Account WHERE Id IN (SELECT AccountId FROM Opportunity WHERE Id IN :oldOpps)]);
        for(Opportunity opp : oldOpps){
            if(opp.StageName == 'Closed Won'){
                if(accounts.get(opp.AccountId).Industry == 'Banking'){
                    opp.addError('Cannot delete closed opportunity');
                }
            }
        }
    }

    public static void setType (List<Opportunity> newOpps) {
        for (Opportunity opp : newOpps) {
            if (opp.Type == null){
                opp.Type = 'New Customer';
            }    
        }
    }

    public static void setPrimaryContact (List<Opportunity> newOpps) {
        //Get contacts related to the opportunity account
        Set<Id> accountIds = new Set<Id>();
        for(Opportunity opp : newOpps){
            accountIds.add(opp.AccountId);
        }
        
        Map<Id, Contact> contacts = new Map<Id, Contact>([SELECT Id, FirstName, AccountId FROM Contact WHERE AccountId IN :accountIds AND Title = 'CEO' ORDER BY FirstName ASC]);
        Map<Id, Contact> accountIdToContact = new Map<Id, Contact>();

        for (Contact cont : contacts.values()) {
            if (!accountIdToContact.containsKey(cont.AccountId)) {
                accountIdToContact.put(cont.AccountId, cont);
            }
        }

        for(Opportunity opp : newOpps){
            if(opp.Primary_Contact__c == null){
                if (accountIdToContact.containsKey(opp.AccountId)){
                    opp.Primary_Contact__c = accountIdToContact.get(opp.AccountId).Id;
                }
            }
        }
    }

}