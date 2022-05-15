public with sharing class MultiComparableSort 
{
    public static void Run() 
    {
        List<MultiComparable> listToSort=new List<MultiComparable>();

        for (Integer idx=0; idx<Config.LIST_SIZE; idx++)
        {
            listToSort.add(new MultiComparable((Math.random()*100000).intValue(), 
                                                (Math.random()*50000).intValue()));
        }

        Long startCpu=Limits.getCpuTime();
        listToSort.sort();
        Long consumedCpu=Limits.getCpuTime()- startCpu;

        System.debug('MultiComparableSort consumed CPU = ' + consumedCpu);
    }

    class MultiComparable implements Comparable
    {
        public Integer intValue;
        public Integer intValue2;

        MultiComparable(Integer intValue, Integer intValue2)
        {
            this.intValue=intValue;
            this.intValue2=intValue2;
        }

        public Integer compareTo(Object compareTo)
        {
            Integer result=0;
            MultiComparable other=(MultiComparable) compareTo;
            Long value=intValue*intValue2;
            Long otherValue=other.intValue*other.intValue2;
            if (value>otherValue)
            {
                result=1;
            }
            else if (value<otherValue)
            {
                result=-1;
            }

            return result;
        }
    }
}
