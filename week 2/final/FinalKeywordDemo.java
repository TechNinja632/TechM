final class FinalClass {
    final int finalVariable;

    public FinalClass(int value) {
        this.finalVariable = value;
    }

    public final void finalMethod() {
        System.out.println("This is a final method. Value of finalVariable: " + finalVariable);
    }
}

public class FinalKeywordDemo {
    public static void main(String[] args) {
        FinalClass finalClass = new FinalClass(10);

        System.out.println("Final variable value: " + finalClass.finalVariable);

        finalClass.finalMethod();
    }
}
