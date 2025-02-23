import java.util.*;  
import java.util.stream.*;  

public class SortStrings {  
    public static void main(String[] args) {  
        List<String> fruits = Arrays.asList("Mango", "Apple", "Banana");  
        List<String> asc = fruits.stream().sorted().collect(Collectors.toList());  
        List<String> desc = fruits.stream().sorted(Collections.reverseOrder()).collect(Collectors.toList());  
        System.out.println("Asc: " + asc + " | Desc: " + desc);  
    }  
}  