trigger contactTrigger on contact(before insert,before update)
{   
    set<Id> accids=new set<Id>();
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate))
    {

    }
}