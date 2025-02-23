import java.util.*;  

public class LetterCounter {  
    public static void main(String[] args) {  
        List<String> words = Arrays.asList("apple", "avocado", "banana");  
        long count = words.stream().filter(w -> w.startsWith("a")).count();  
        System.out.println("Starts with 'a': " + count);  
    }  
}  