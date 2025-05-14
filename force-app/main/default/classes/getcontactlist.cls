public with sharing class getcontactlist {
    @AuraEnabled(cacheable=true)
    public static list<contact> getcontactlist1() {
      return [select Id,FirstName,LastName,Email,Phone from contact limit 10];
    }
}