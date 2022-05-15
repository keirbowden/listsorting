public with sharing class MultiMethodComparableSort {
    public static void Run() 
    {
        List<MultiMethodComparable> listToSort=new List<MultiMethodComparable>();

        for (Integer idx=0; idx<Config.LIST_SIZE; idx++)
        {
            listToSort.add(new MultiMethodComparable((Math.random()*100000).intValue(), 
                                                     (Math.random()*50000).intValue()));
        }

        Long startCpu=Limits.getCpuTime();
        listToSort.sort();
        Long consumedCpu=Limits.getCpuTime()- startCpu;

        System.debug('MultiMethodComparable consumed CPU = ' + consumedCpu);
    }

    class MultiMethodComparable implements Comparable
    {
        Integer value1;
        Integer value2;

        public Integer getValue1()
        {
            return this.value1;
        }

        public Integer getValue2()
        {
            return this.value2;
        }

        MultiMethodComparable(Integer value1, Integer value2)
        {
            this.value1=value1;
            this.value2=value2;
        }

        public Integer compareTo(Object compareTo)
        {
            Integer result=0;
            MultiMethodComparable other=(MultiMethodComparable) compareTo;
            if (value1*value2>other.getValue1()*other.getValue2())
            {
                result=1;
            }
            else if (value1*value2<other.getValue1()*other.getValue2())
            {
                result=-1;
            }

            return result;
        }
    }
}
