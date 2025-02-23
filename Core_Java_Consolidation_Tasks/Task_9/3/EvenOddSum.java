import java.util.*;  

public class EvenOddSum {  
    public static void main(String[] args) {  
        List<Integer> vals = Arrays.asList(1,2,3,4,5);  
        long evenSum = vals.stream().filter(n -> n%2==0).mapToInt(n -> n).sum();  
        long oddSum = vals.stream().filter(n -> n%2!=0).mapToInt(n -> n).sum();  
        System.out.println("Even: " + evenSum + " | Odd: " + oddSum);  
    }  
}  