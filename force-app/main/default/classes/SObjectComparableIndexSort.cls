public with sharing class SObjectComparableIndexSort 
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
        List<SObjectComparableIndex> listToSort=new List<SObjectComparableIndex>();

        for (Integer idx=0; idx<Config.LIST_SIZE; idx++)
        {
            Opportunity opp=new Opportunity(Name='Test Opp ' + idx,
            CloseDate=System.today().addDays((Math.random()*100-50).intValue()),
            Amount=(Math.random()*5000000).intValue());
    
            String stage=SObjectComparableIndexSort.STAGES[(Math.random()*10).intValue()];
            opp.StageName=stage;
    
            listToSort.add(new SObjectComparableIndex(opp));
        }

        Long startCpu=Limits.getCpuTime();
        listToSort.sort();
        Long consumedCpu=Limits.getCpuTime()- startCpu;

        System.debug('SObjectComparableIndexSort consumed CPU = ' + consumedCpu);
    }

    class SObjectComparableIndex implements Comparable
    {
        public Opportunity opp;
        public Integer stageIdx;

        SObjectComparableIndex(Opportunity opp)
        {
            this.opp=opp;
            this.stageIdx=SObjectComparableIndexSort.STAGES.indexOf(opp.StageName);
        }

        public Integer compareTo(Object compareTo)
        {
            Integer result=0;
            SObjectComparableIndex other=(SObjectComparableIndex) compareTo;

            if (stageIdx>other.stageIdx)
            {
                result=1;
            }
            else if (stageIdx<other.stageIdx)
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
