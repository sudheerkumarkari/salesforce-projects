public with sharing class cl_accountData {
    @AuraEnabled(cacheable=true)
    public static List<Account> AccountMethod() 
    {  
        List<Account> accounts= [SELECT Id,Name,Phone,Industry FROM Account limit 10];
        return accounts;
    
    }
   }