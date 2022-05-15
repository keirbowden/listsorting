public with sharing class PrimitiveSort 
{
    public static void Run() 
    {
        List<Integer> listToSort=new List<Integer>();

        for (Integer idx=0; idx<Config.LIST_SIZE; idx++)
        {
            listToSort.add((Math.random()*100000).intValue());
        }

        Long startCpu=Limits.getCpuTime();
        listToSort.sort();
        Long consumedCpu=Limits.getCpuTime()- startCpu;

        System.debug('Primitive sort, consumed CPU = ' + consumedCpu);
    }
}
