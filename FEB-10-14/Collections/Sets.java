package Collections;

import java.util.*;

public class Sets {
    public static void main(String[] args) {
        HashSet<Integer> hs = new HashSet<>();
        LinkedHashSet<String> lhs = new LinkedHashSet<>();
        TreeSet<Double> ts = new TreeSet<>();
        Sets s = new Sets();
        s.SetSample(hs);
        s.SetSample(lhs);
        s.SetSample(ts);

    }
    public void SetSample(HashSet<Integer> hs){
        hs.add(1);hs.add(2);hs.add(3);
        hs.add(4);hs.add(5);hs.add(6);
        hs.add(7);hs.add(8);
        System.out.println("HashSet Size: " + hs.size());
        System.out.println("Elements in HashSet: " + hs);
        hs.remove(8);
        System.out.println("HashSet after removing element : " + hs);
        System.out.print("Using iterator : ");
        System.out.println("HashSet Size: " + hs.size());
        System.out.println("Elements in HashSet: " + hs);
        Iterator<Integer> iterator = hs.iterator();
        System.out.print("Numbers Divisible by 7: ");
        while (iterator.hasNext()){
            int i  = iterator.next();
            if (i % 7 == 0){
                System.out.print(i + " ");
            }
        }

        System.out.println();
    }

    public void SetSample(LinkedHashSet<String> lhs){
        lhs.add("A");lhs.add("B");lhs.add("C");
        lhs.add("D");lhs.add("E");lhs.add("F");
        lhs.add("Programming");lhs.add("G");
        System.out.println("LinkedHashSet Size: " + lhs.size());
        System.out.println("Elements in LinkedHashSet: " + lhs);
        lhs.remove("G");
        System.out.println("LinkedHashSet after removing element : " + lhs);
        System.out.print("Using iterator : ");
        System.out.println("LinkedHashSet Size: " + lhs.size());
        System.out.println("Elements in LinkedHashSet: " + lhs);
        Iterator<String> iterator = lhs.iterator();
        System.out.print("Words having letters more than 5: ");
        while (iterator.hasNext()){
            String i  = iterator.next();
            if (i.length() > 5){
                System.out.print(i + " ");
            }
        }

        System.out.println();
    }

    public void SetSample(TreeSet<Double> ts){
        ts.add(1.0);ts.add(2.0);ts.add(3.0);
        ts.add(4.0);ts.add(5.0);ts.add(6.0);
        ts.add(45.78);ts.add(7.0);
        System.out.println("TreeSet Size: " + ts.size());
        System.out.println("Elements in TreeSet: " + ts);
        ts.remove(7.0);
        System.out.println("TreeSet after removing element : " + ts);
        System.out.print("Using iterator : ");
        System.out.println("TreeSet Size: " + ts.size());
        System.out.println("Elements in TreeSet: " + ts);
        Iterator<Double> iterator = ts.iterator();
        System.out.print("Number that is greater than 20: ");
        while (iterator.hasNext()){
            Double i  = iterator.next();
            if (i > 20){
                System.out.print(i + " ");
            }
        }

        System.out.println();
    }
}
