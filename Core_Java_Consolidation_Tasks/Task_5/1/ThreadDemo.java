public class ThreadDemo extends Thread {
    public void run() {
        System.out.println("Hello, Java!");
    }

    public static void main(String[] z) {
        ThreadDemo t = new ThreadDemo();
        t.start();
    }
}