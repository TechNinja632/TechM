
public class Main {
    public static void main(String[] args) {
        
        Car[] cars = {
                new Car("Toyota", "Camry", 2020),
                new ElectricCar("Tesla", "Model S", 2023, 400),
                new Car("Ford", "Mustang", 2021),
                new ElectricCar("Nissan", "Leaf", 2022, 150)
        };

        
        for (Car car : cars) {
            car.startEngine();
        }
    }
}
