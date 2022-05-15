public with sharing class SimpleComparableSort 
{
    public static void Run() 
    {
        List<SimpleComparable> listToSort=new List<SimpleComparable>();

        for (Integer idx=0; idx<Config.LIST_SIZE; idx++)
        {
            listToSort.add(new SimpleComparable((Math.random()*100000).intValue()));
        }

        Long startCpu=Limits.getCpuTime();
        listToSort.sort();
        Long consumedCpu=Limits.getCpuTime()- startCpu;

        System.debug('SimpleComparableSort consumed CPU = ' + consumedCpu);
    }

    class SimpleComparable implements Comparable
    {
        public Integer value;

        SimpleComparable(Integer value)
        {
            this.value=value;
        }

        public Integer compareTo(Object compareTo)
        {
            Integer result=0;
            SimpleComparable other=(SimpleComparable) compareTo;
            if (value>other.value)
            {
                result=1;
            }
            else if (value<other.value)
            {
                result=-1;
            }

            return result;
        }
    }
}
