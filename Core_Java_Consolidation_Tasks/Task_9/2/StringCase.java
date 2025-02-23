import java.util.*;  
import java.util.stream.*;  

public class StringCase {  
    public static void main(String[] args) {  
        List<String> strs = List.of("Apple", "Banana", "Cherry");  
        List<String> upper = strs.stream().map(s -> s.toUpperCase()).collect(Collectors.toList());  
        System.out.println(upper);  
    }  
}  