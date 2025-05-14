public with sharing class class_contact_search {
    @AuraEnabled(cacheable=true)
    public static list<contact> searchcontacts(string searchkey){
       string sk='%'+searchkey+'%';
       Return [select Id,Name,Phone,Email from Contact where FirstName like:sk];
    }
}