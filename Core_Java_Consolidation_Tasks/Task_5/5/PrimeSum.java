public class PrimeSum {
    static int total = 0;

    static boolean checkPrime(int n) {
        if (n < 2) return false;
        for (int i=2; i*i<=n; i++) if (n%i ==0) return false;
        return true;
    }

    public static void main(String[] args) throws Exception {
        int max = 30;
        Thread t1 = new Thread(() -> {
            for (int i=2; i<=max/2; i++) {
                if (checkPrime(i)) {
                    synchronized(PrimeSum.class) { total += i; }
                }
            }
        });

        Thread t2 = new Thread(() -> {
            for (int i=max/2+1; i<=max; i++) {
                if (checkPrime(i)) {
                    synchronized(PrimeSum.class) { total += i; }
                }
            }
        });

        t1.start();
        t2.start();
        t1.join();
        t2.join();
        System.out.println("Total: " + total);
    }
}