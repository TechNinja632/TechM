package Collections;

import java.util.*;

public class ListTypes {
    public static void main(String[] args){
            Arraylst Al = new Arraylst();
            Linkedlist Ll = new Linkedlist();
            Stk St = new Stk();
            Vctr Vct = new Vctr();

            Al.start();
            Ll.start();
            St.start();
            Vct.start();
    }
}
class Arraylst extends Thread{
    public void run (){
    List<Integer> list1 = new ArrayList<>();
        list1.add(35);
        list1.add(23);
        list1.add(67);
        list1.add(82);
        list1.add(56);
        list1.add(49);
        list1.add(49);
        list1.add(49);
        System.out.println("Number of elements in the list: "+list1.size());
        list1.add(12);
        System.out.println("After adding one element:");
        System.out.println("The given list is :"+list1);
        System.out.println("The number of elements in the list: "+list1.size());
        System.out.println("Is 566 available in the list:"+list1.contains(566));
        System.out.println("The given list before removing elements is :"+list1);
        list1.remove(2);
        list1.remove(3);
        System.out.println("After removing elements:");
        System.out.println("The given list is :"+list1);
        System.out.println("The number of elements in the list: "+list1.size());
    }
}

class Linkedlist extends Thread{
    public void run(){
        List<Integer> list1 = new LinkedList<>();
        list1.add(35);
        list1.add(23);
        list1.add(67);
        list1.add(82);
        list1.add(56);
        list1.add(49);
        list1.add(49);
        list1.add(49);
        System.out.println("Number of elements in the list: "+list1.size());
        list1.add(12);
        System.out.println("After adding one element:");
        System.out.println("The given list is :"+list1);
        System.out.println("The number of elements in the list: "+list1.size());
        System.out.println("Is 566 available in the list:"+list1.contains(566));
        System.out.println("The given list before removing elements is :"+list1);
        list1.remove(2);
        list1.remove(3);
        System.out.println("After removing elements:");
        System.out.println("The given list is :"+list1);
        System.out.println("The number of elements in the list: "+list1.size());
    }
}

class Stk extends Thread{
    public void run(){
        List<Integer> list1 = new Stack<>();
        list1.add(35);
        list1.add(23);
        list1.add(67);
        list1.add(82);
        list1.add(56);
        list1.add(49);
        list1.add(49);
        list1.add(49);
        System.out.println("Number of elements in the list: "+list1.size());
        list1.add(12);
        System.out.println("After adding one element:");
        System.out.println("The given list is :"+list1);
        System.out.println("The number of elements in the list: "+list1.size());
        System.out.println("Is 566 available in the list:"+list1.contains(566));
        System.out.println("The given list before removing elements is :"+list1);
        list1.remove(2);
        list1.remove(3);
        System.out.println("After removing elements:");
        System.out.println("The given list is :"+list1);
        System.out.println("The number of elements in the list: "+list1.size());
    }
}

class Vctr extends Thread{
    public void run(){
        List<Integer> list1 = new Vector<>();
        list1.add(35);
        list1.add(23);
        list1.add(67);
        list1.add(82);
        list1.add(56);
        list1.add(49);
        list1.add(49);
        list1.add(49);
        System.out.println("Number of elements in the list: "+list1.size());
        list1.add(12);
        System.out.println("After adding one element:");
        System.out.println("The given list is :"+list1);
        System.out.println("The number of elements in the list: "+list1.size());
        System.out.println("Is 566 available in the list:"+list1.contains(566));
        System.out.println("The given list before removing elements is :"+list1);
        list1.remove(2);
        list1.remove(3);
        System.out.println("After removing elements:");
        System.out.println("The given list is :"+list1);
        System.out.println("The number of elements in the list: "+list1.size());
    }
}