public class AccountController {

    // Method to fetch account details by accountId
    @AuraEnabled(cacheable=true)
    public static Account getAccountDetails(String accountId) {
        try {
            // Query account details based on the provided accountId
            Account acc = [SELECT Id, Name, Industry, Status FROM Account WHERE Id = :accountId LIMIT 1];
            return acc;
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching account details: ' + e.getMessage());
        }
    }

    // Method to update account status
    @AuraEnabled
    public static void updateAccountStatus(String accountId, String newStatus) {
        try {
            // Query the account to update its status
            Account acc = [SELECT Id, Status FROM Account WHERE Id = :accountId LIMIT 1];
            acc.Status = newStatus;
            update acc;  // Perform the update operation
        } catch (Exception e) {
            throw new AuraHandledException('Error updating account status: ' + e.getMessage());
        }
    }
}
