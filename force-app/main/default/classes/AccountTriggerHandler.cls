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
        // setTypeProspect Helper
        for (Account acc : newAccList) {
            if (acc.Type == null) {
                acc.Type = 'Prospect';
            }
        }

        //addressCopy Helper
        for (Account acc : newAccList) {
            if (acc.ShippingStreet != null) {
                acc.BillingStreet = acc.ShippingStreet;
            }

            if (acc.ShippingCity != null) {
                acc.BillingCity = acc.ShippingCity;
            }

            if (acc.ShippingState != null) {
                acc.BillingState = acc.ShippingState;
            }

            if (acc.ShippingPostalCode != null) {
                acc.BillingPostalCode = acc.ShippingPostalCode;
            }

            if (acc.ShippingCountry != null) {
                acc.BillingCountry = acc.ShippingCountry;
            }
        }
        
        // setRating Helper
        for (Account acc : newAccList) {
            if (acc.Phone != null && acc.Website != null && acc.Fax != null) {
                acc.Rating = 'Hot';
            }
        }
    }

    public override void afterInsert() {
        // defaultContact Helper
        List<Contact> contacts = new List<Contact>();   
        for(Account acc : newAccList){
            Contact con = new Contact();
            con.LastName = 'DefaultContact';
            con.Email = 'default@email.com';
            con.AccountId = acc.Id;
            contacts.add(con);
        }
        insert contacts; 
    }

}