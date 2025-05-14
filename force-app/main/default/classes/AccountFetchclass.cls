public with sharing class AccountFetchclass {
   
    @AuraEnabled(cacheable=true)
    public static List<Account> AccountFetch() {
        return [select Id,Name from Account Limit 5];

    }
}