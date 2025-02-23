import java.util.*;

public class NumberCruncher {
    public static <T extends Number> Map<String, Long> sumSplit(List<T> list) {
        long even = 0, odd = 0;
        for (T num : list) {
            long val = num.longValue();
            if (val % 2 == 0) even += val;
            else odd += val;
        }
        return Map.of("even", even, "odd", odd);
    }

    public static void main(String[] args) {
        List<Integer> numbers = Arrays.asList(1,2,3,4);
        System.out.println(sumSplit(numbers));
    }
}