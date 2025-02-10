import java.util.ArrayList;
import java.util.List;

public class AnagramFinder {

    public static List<Integer> findAnagrams(String s, String p) {
        List<Integer> result = new ArrayList<>();

        if (s == null || p == null || s.length() < p.length()) {
            return result;
        }

        int[] pCount = new int[26]; 
        int[] sCount = new int[26];

        
        for (char c : p.toCharArray()) {
            pCount[c - 'a']++;
        }

        int windowSize = p.length();
        int left = 0, right = 0;

       
        while (right < s.length()) {
            
            sCount[s.charAt(right) - 'a']++;

            if (right - left + 1 == windowSize) {
                if (matches(pCount, sCount)) {
                    result.add(left); 
                }

                
                sCount[s.charAt(left) - 'a']--;
                left++;
            }

            right++;
        }

        return result;
    }

  
    private static boolean matches(int[] pCount, int[] sCount) {
        for (int i = 0; i < 26; i++) {
            if (pCount[i] != sCount[i]) {
                return false;
            }
        }
        return true;
    }

    public static void main(String[] args) {
        String s = "cbaebabacd";
        String p = "abc";

        List<Integer> indices = findAnagrams(s, p);
        System.out.println("Starting indices of anagrams: " + indices);
    }
}
