package Collections;

import java.util.*;

public class HashMapAndTable {
    public static void main(String[] args){
        HashMapAndTable hm = new HashMapAndTable();
        hm.Hashmap();
        hm.Hashtable();
    }

    void Hashmap(){
        HashMap<Integer, String> hm = new HashMap<>();
        hm.put(1, "one");
        hm.put(2, "two");
        hm.put(3, "three");
        System.out.println("Initial HashMap hm1 are : "
                + hm);
        hm.put(2, "For");
        System.out.println("Updated Map " + hm);
        hm.remove(1);
        System.out.println("Mappings after removal are : "
                + hm);
        System.out.println("Map traversal:");

        for (Map.Entry<Integer, String> e : hm.entrySet())
            System.out.println("Key: " + e.getKey()
                    + " Value: " + e.getValue());
    }

    void Hashtable(){
        Hashtable<Integer, String> hm = new Hashtable<>();
        hm.put(1, "one");
        hm.put(2, "two");
        hm.put(3, "three");
        System.out.println("Initial HashMap hm1 are : "
                + hm);
        hm.put(2, "For");
        System.out.println("Updated Map " + hm);
        hm.remove(1);
        System.out.println("Mappings after removal are : "
                + hm);
        System.out.println("Map traversal:");

        for (Map.Entry<Integer, String> e : hm.entrySet())
            System.out.println("Key: " + e.getKey()
                    + " Value: " + e.getValue());
    }
}
