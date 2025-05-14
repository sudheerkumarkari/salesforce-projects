public with sharing class cl_practice7 {
    @AuraEnabled(cacheable=true)
    
    public static List<Contact> getcontactlist() {
        return [select Id,FirstName,LastName,Phone,Email from Contact limit 10];


    }
}