import java.util.*;  

public class MinMax {  
    public static void main(String[] args) {  
        List<Integer> data = Arrays.asList(15, 3, 9, 22);  
        int maxVal = data.stream().mapToInt(x -> x).max().orElse(0);  
        int minVal = data.stream().mapToInt(x -> x).min().orElse(0);  
        System.out.println("Max: " + maxVal + " | Min: " + minVal);  
    }  
}  