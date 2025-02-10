abstract class Animal {
    public abstract void makeSound();
}

class Dog extends Animal {
    @Override
    public void makeSound() {
        System.out.println("The dog is barking.");
    }
}

public class AnimalDemo {
    public static void main(String[] args) {
        Dog dog = new Dog();
        dog.makeSound();
    }
}
