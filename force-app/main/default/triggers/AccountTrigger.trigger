trigger AccountTrigger on Account (after update) {
    set<Id> accids=new set<Id>();
    if(Trigger.isAfter && trigger.isUpdate)
    {
        for(Account acc:trigger.new)
        {
            accids.add(acc.Id);
        }
        if(!accids.isEmpty())
        {
            Date day30= date.today() - 30;
            list<Opportunity> updateopp= new list<opportunity>();
           List<Opportunity> oppids=[select Id,AccountId,stagename,test_created_date__c from opportunity where AccountId IN: accids];
           IF(!oppids.isEmpty())
           {
            for(Opportunity opp:oppids)
            {
                if(opp.test_created_date__c< day30 && opp.stagename!='Closed Won' )
                {
                    opp.test_created_date__c=date.today();
                    opp.stagename='Closed Lost';
                    updateopp.add(opp);

                }
            }
           }
           if(!updateopp.isEmpty())
           {
            update updateopp;
           }
        }

    }
   
}