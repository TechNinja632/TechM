import java.io.*;

public class FindPDFs {
    public static void main(String[] args) {
        File folder = new File("/docs");
        FilenameFilter pdfFilter = (dir, name) -> name.endsWith(".pdf");
        String[] pdfFiles = folder.list(pdfFilter);
        for (String f : pdfFiles) {
            System.out.println(f);
        }
    }
}