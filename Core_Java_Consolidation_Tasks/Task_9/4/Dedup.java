import java.util.*;  
import java.util.stream.*;  

public class Dedup {  
    public static void main(String[] args) {  
        List<String> items = List.of("A", "B", "A", "C");  
        List<String> unique = items.stream().distinct().collect(Collectors.toList());  
        System.out.println(unique);  
    }  
}  