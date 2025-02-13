import java.io.*;

class Transient implements Serializable {
    Transient(int eno, String ename, String email){
        this.eno = eno;
        this.ename = ename;
        this.email = email;
    }
    int eno;
    String ename;
    transient String email;

    public static void Serialization(int eno, String ename, String email) throws IOException{
        try{
            Transient e1 = new Transient(eno, ename, email);
            FileOutputStream eout = new FileOutputStream("e.txt");
            ObjectOutputStream out = new ObjectOutputStream(eout);
            out.writeObject(e1);
            out.flush();
            out.close();
            System.out.println("success");
        }catch (Exception e) {
            System.out.println(e);
        }
    }

    public static void Deserialization(String fname){
        try{
            ObjectInputStream in = new ObjectInputStream(new FileInputStream(fname));
            Transient e = (Transient)in.readObject();
            System.out.println(e.eno +" "+ e.ename +" "+ e.email);
            in.close();
        }catch(Exception e){System.out.println(e);}
    }
    public static void main(String[] args) throws IOException{
        Serialization(001, "Alan", "alan@gmail.com");
        Deserialization("e.txt");
    }
}
