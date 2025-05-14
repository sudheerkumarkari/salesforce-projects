trigger ContactTrigger on Contact (afer insert,after update,after delete,after undelete) {
    set<id> accids=new set<id>();
    if(trigger.isAfter &&(trigger.isInsert|| trigger.isUndelete))
    {
        for(contact con :trigger.new)
        {
          if(con.AccoundId!=null)
          {
            accids.add(con.AccoundId);
          }
        }

    }
    if(trigger.isAfter && trigger.isUpdate)
    {
        for(contact con:trigger.new)
        {
            if(con.AccountId!=trigger.oldMap.get(con.Id).AccountId)
            {
                if(trigger.oldMap.get(con.Id).AccountId!=null)
                {
                    accids.add(trigger.oldMap.get(con.Id).AccountId);
                }
                if(con.AccountId!=null)
                {
                    accids.add(con.AccountId);
                }
            }
        }
    }
    if(trigger.isAfter&&trigger.isDelete)
    {
        for(contact con:trigger.old)
        {
            if(con.AccountId!=null)
            {
                accids.add(con.AccountId);
            }
        }
    }
    
   

}