import java.util.*;  

public class StreamAvg {  
    public static void main(String[] args) {  
        List<Integer> nums = Arrays.asList(5, 3, 8, 1);  
        double avg = nums.stream().mapToInt(x -> x).average().orElse(0);  
        System.out.println("Average: " + avg);  
    }  
}  