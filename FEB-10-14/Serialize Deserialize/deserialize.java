import java.io.FileInputStream;
import java.io.ObjectInputStream;

class deserialize {
public static void main(String[] args) {
    try{
        ObjectInputStream in=new ObjectInputStream(new FileInputStream("f.txt"));
        serialize s=(serialize)in.readObject();
        System.out.println(s.rno+" "+s.name);
        in.close();
    }catch(Exception e){System.out.println(e);}
}}