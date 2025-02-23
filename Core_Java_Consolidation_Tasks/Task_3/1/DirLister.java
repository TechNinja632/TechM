import java.io.File;

public class DirLister {
    public static void main(String[] args) {
        File dir = new File("/path/to/folder");
        if (!dir.exists()) {
            System.out.println("Folder missing!");
            return;
        }
        String[] stuff = dir.list();
        for (String item : stuff) {
            System.out.println(item);
        }
    }
}