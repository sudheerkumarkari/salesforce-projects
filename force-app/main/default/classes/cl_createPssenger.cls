public with sharing class cl_createPssenger {
    @AuraEnabled
    public static string passmMethod(string fName,string email) {
        string result;
        try{
            passenger__c p= new passenger__c();
            p.Name=fName;
            p.passenger_email__c=email;
            insert p;
            result='Record created succesfully :'+p.id;

        }
        catch(Exception e)
        {
           result='record not created succesfully'+e.getMessage();
        }
        return result;

    }
}