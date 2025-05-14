public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static Contact getContactDetails(Id contactId) {
        if (contactId == null) {
            throw new AuraHandledException('Contact Id cannot be null');
        }
        
        // Query the Contact record based on the contactId
        Contact contact = [SELECT Id, Name, Title FROM Contact WHERE Id = :contactId LIMIT 1];
        return contact;
    }

    @AuraEnabled
    public static String updateContactTitle(Id contactId, String newTitle) {
        if (contactId == null || newTitle == null) {
            throw new AuraHandledException('Invalid Contact Id or Title');
        }
        
        Contact contact = [SELECT Id, Title FROM Contact WHERE Id = :contactId LIMIT 1];
        contact.Title = newTitle;
        update contact;
        return 'Title updated successfully!';
    }
}
