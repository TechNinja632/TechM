package Thread;

public class thread {
    public static void main(String[] args) {

        new ThreadOne().start();

        ThreadTwo t2_1 = new ThreadTwo();
        ThreadTwo t2_2 = new ThreadTwo();
        t2_1.start();
        t2_2.start();
        new ThreadTwo().run();

        new ThreadThree().start();
        new ThreadThree().start();
        new ThreadThree().start();


        new Thread(new ThreadRunnableOne()).start();

        new Thread(new ThreadRunnableTwo()).start();
        new Thread(new ThreadRunnableTwo()).start();
    }
}

class ThreadOne extends Thread {
    public void run() {
        System.out.println("From ThreadOne!");
        System.out.println("From ThreadOne!");
        System.out.println("From ThreadOne!");
    }
}

class ThreadTwo extends Thread {
    public void run() {
        System.out.println("From ThreadTwo!");
        System.out.println("From ThreadTwo!");
        System.out.println(10 / 0);
    }
}

class ThreadThree extends Thread {
    public void run() {
        System.out.println("From ThreadThree!");
        System.out.println("From ThreadThree!");
        System.out.println("From ThreadThree!");
        System.out.println("From ThreadThree!");
        System.out.println("From ThreadThree!");
    }
}

class ThreadRunnableOne implements Runnable {
    public void run() {
        System.out.println("From ThreadRunnableOne!");
        System.out.println("From ThreadRunnableOne!");
    }
}

class ThreadRunnableTwo implements Runnable {
    public void run() {
        System.out.println("From ThreadRunnableTwo!");
        System.out.println("From ThreadRunnableTwo!");
        System.out.println("From ThreadRunnableTwo!");
    }
}