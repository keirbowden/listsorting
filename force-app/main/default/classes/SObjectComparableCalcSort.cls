public with sharing class SObjectComparableCalcSort 
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
        List<SObjectComparableCalc> listToSort=new List<SObjectComparableCalc>();

        for (Integer idx=0; idx<Config.LIST_SIZE; idx++)
        {
            Opportunity opp=new Opportunity(Name='Test Opp ' + idx,
            CloseDate=System.today().addDays((Math.random()*100-50).intValue()),
            Amount=(Math.random()*5000000).intValue());
    
            String stage=SObjectComparableCalcSort.STAGES[(Math.random()*10).intValue()];
            opp.StageName=stage;
    
            listToSort.add(new SObjectComparableCalc(opp));
        }

        Long startCpu=Limits.getCpuTime();
        listToSort.sort();
        Long consumedCpu=Limits.getCpuTime()- startCpu;

        System.debug('SObjectComparableCalcSort consumed CPU = ' + consumedCpu);
    }

    class SObjectComparableCalc implements Comparable
    {
        public Opportunity opp;
        public Double calcValue;

        SObjectComparableCalc(Opportunity opp)
        {
            this.opp=opp;
            this.calcValue=SObjectComparableCalcSort.STAGES.indexOf(opp.StageName);
            this.calcValue*=10000000;
            this.calcValue+=opp.Amount;
        }

        public Integer compareTo(Object compareTo)
        {
            Integer result=0;
            SObjectComparableCalc other=(SObjectComparableCalc) compareTo;

            if (calcValue>other.calcValue)
            {
                result=1;
            }
            else if (calcValue<other.calcValue)
            {
                result=-1;
            }

            return result;
        }
    }
}
