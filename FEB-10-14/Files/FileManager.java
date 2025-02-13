import java.io.File;
import java.io.IOException;
import java.util.Scanner;

public class FileManager {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Select an option:");
        System.out.println("1. Create 3 files");
        System.out.println("2. Create a 'Reports' folder with 3 files");
        System.out.println("3. Create a 'Logs' folder with 4 files");
        
        int choice = scanner.nextInt();
        scanner.nextLine();

        if (choice == 1) {
            createFiles(".", 3);
        } else if (choice == 2) {
            createDirectoryWithFiles("Reports", 3);
        } else if (choice == 3) {
            createDirectoryWithFiles("Logs", 4);
        } else {
            System.out.println("Invalid selection.");
        }
        
        scanner.close();
    }

    private static void createFiles(String path, int count) {
        for (int i = 1; i <= count; i++) {
            File file = new File(path, "Document" + i + ".txt");
            try {
                if (file.createNewFile()) {
                    System.out.println("Created: " + file.getAbsolutePath());
                } else {
                    System.out.println("Exists: " + file.getAbsolutePath());
                }
            } catch (IOException e) {
                System.out.println("Error: " + e.getMessage());
            }
        }
    }

    private static void createDirectoryWithFiles(String dirName, int count) {
        File dir = new File(dirName);
        if (!dir.exists()) {
            if (dir.mkdir()) {
                System.out.println("Folder created: " + dir.getAbsolutePath());
            } else {
                System.out.println("Failed to create folder.");
                return;
            }
        } else {
            System.out.println("Folder already exists: " + dir.getAbsolutePath());
        }
        createFiles(dirName, count);
    }
}
