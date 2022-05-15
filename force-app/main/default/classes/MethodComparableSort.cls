public with sharing class MethodComparableSort {
    public static void Run() 
    {
        List<MethodComparable> listToSort=new List<MethodComparable>();

        for (Integer idx=0; idx<Config.LIST_SIZE; idx++)
        {
            listToSort.add(new MethodComparable((Math.random()*100000).intValue()));
        }

        Long startCpu=Limits.getCpuTime();
        listToSort.sort();
        Long consumedCpu=Limits.getCpuTime()- startCpu;

        System.debug('MethodComparable consumed CPU = ' + consumedCpu);
    }

    class MethodComparable implements Comparable
    {
        Integer value;

        public Integer getValue()
        {
            return this.value;
        }

        MethodComparable(Integer value)
        {
            this.value=value;
        }

        public Integer compareTo(Object compareTo)
        {
            Integer result=0;
            MethodComparable other=(MethodComparable) compareTo;
            if (value>other.getValue())
            {
                result=1;
            }
            else if (value<other.getValue())
            {
                result=-1;
            }

            return result;
        }
    }
}
