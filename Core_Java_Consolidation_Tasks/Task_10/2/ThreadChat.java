class NumberPrinter {  
    boolean isEvenTurn = true;  

    synchronized void printEven(int num) throws InterruptedException {  
        while(!isEvenTurn) wait();  
        System.out.println("Even: " + num);  
        isEvenTurn = false;  
        notify();  
    }  

    synchronized void printOdd(int num) throws InterruptedException {  
        while(isEvenTurn) wait();  
        System.out.println("Odd: " + num);  
        isEvenTurn = true;  
        notify();  
    }  
}  

public class ThreadChat {  
    public static void main(String[] args) {  
        NumberPrinter p = new NumberPrinter();  
        new Thread(() -> {  
            for(int i=2; i<=10; i+=2) try { p.printEven(i); } catch(Exception e){}  
        }).start();  
        new Thread(() -> {  
            for(int i=1; i<10; i+=2) try { p.printOdd(i); } catch(Exception e){}  
        }).start();  
    }  
}  