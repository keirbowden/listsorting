public with sharing class MultiComparableCalcSort 
{
    public static void Run() 
    {
        List<MultiComparableCalc> listToSort=new List<MultiComparableCalc>();

        for (Integer idx=0; idx<Config.LIST_SIZE; idx++)
        {
            listToSort.add(new MultiComparableCalc((Math.random()*100000).intValue(), 
                                                (Math.random()*50000).intValue()));
        }

        Long startCpu=Limits.getCpuTime();
        listToSort.sort();
        Long consumedCpu=Limits.getCpuTime()- startCpu;

        System.debug('MultiComparableCalcCalcSort consumed CPU = ' + consumedCpu);
    }

    class MultiComparableCalc implements Comparable
    {
        public Integer intValue;
        public Integer intValue2;
        public Integer compareValue;

        MultiComparableCalc(Integer intValue, Integer intValue2)
        {
            this.intValue=intValue;
            this.intValue2=intValue2;
            this.compareValue=intValue*intValue2;
        }

        public Integer compareTo(Object compareTo)
        {
            Integer result=0;
            MultiComparableCalc other=(MultiComparableCalc) compareTo;
            if (compareValue>other.compareValue)
            {
                result=1;
            }
            else if (compareValue<other.compareValue)
            {
                result=-1;
            }

            return result;
        }
    }
}
