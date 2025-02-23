import java.io.*;

public class WhatIsIt {
    public static void main(String[] args) {
        File thing = new File("/tmp");
        System.out.println(thing.isDirectory() ? "Folder" : "File");
    }
}