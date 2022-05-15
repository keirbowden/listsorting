public with sharing class SObjectComparableSort 
{
    public static final List<String> STAGES=new List<String>{
        'Prospecting', 'Qualification',
        'Needs Analysis', 'Value Proposition',
        'Value Proposition', 'Perception Analysis',
        'Proposal/Price Quote', 'Negotiation/Review',
        'Closed Won', 'Closed Lost'
    };

    public static void Run() 
    {
        List<SObjectComparable> listToSort=new List<SObjectComparable>();

        for (Integer idx=0; idx<Config.LIST_SIZE; idx++)
        {
            Opportunity opp=new Opportunity(Name='Test Opp ' + idx,
            CloseDate=System.today().addDays((Math.random()*100-50).intValue()),
            Amount=(Math.random()*5000000).intValue());
    
            String stage=SObjectComparableSort.STAGES[(Math.random()*10).intValue()];
            opp.StageName=stage;
    
            listToSort.add(new SObjectComparable(opp));
        }

        Long startCpu=Limits.getCpuTime();
        listToSort.sort();
        Long consumedCpu=Limits.getCpuTime()- startCpu;

        System.debug('SObjectComparableSort consumed CPU = ' + consumedCpu);
    }

    class SObjectComparable implements Comparable
    {
        public Opportunity opp;

        SObjectComparable(Opportunity opp)
        {
            this.opp=opp;
        }

        public Integer compareTo(Object compareTo)
        {
            Integer result=0;
            SObjectComparable other=(SObjectComparable) compareTo;

            Integer pos=SObjectComparableSort.STAGES.indexOf(opp.StageName);
            Integer otherPos=SObjectComparableSort.STAGES.indexOf(other.opp.StageName);
            if (pos>otherPos)
            {
                result=1;
            }
            else if (pos<otherPos)
            {
                result=-1;
            }
            else {
                if (opp.Amount>other.opp.Amount)
                {
                    result=1;
                }
                else if (opp.Amount<other.opp.Amount)
                {
                    result=-1;
                }
            }

            return result;
        }
    }
}
