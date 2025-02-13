import java.io.*;
import java.lang.*;
    class serialize implements Serializable
    {
        serialize(int rno, String name){
            this.rno=rno;
            this.name=name;
        }
        int rno;
        String name;
public static void main(String[] args) throws IOException {
    try {
        serialize s1 = new serialize(211, "ravi");
        FileOutputStream fout = new FileOutputStream("f.txt");
        ObjectOutputStream out = new ObjectOutputStream(fout);
        out.writeObject(s1);
        out.flush();
        out.close();
        System.out.println("success");
    } catch (Exception e) {
        System.out.println(e);
    }

}
    }
