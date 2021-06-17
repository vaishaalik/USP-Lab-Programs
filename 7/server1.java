import java.net.*;
import java.io.*;

public class Server1 {
public static void main(String args[])throws IOException
{
ServerSocket sersock=new ServerSocket(5009);
System.out.println("Server started");
Socket sock =sersock.accept();
System.out.println("Server ready to accept incoming request");
InputStream istream=sock.getInputStream();
BufferedReader br= new BufferedReader(new InputStreamReader(istream));
String fname=br.readLine();
BufferedReader contentRead= new BufferedReader(new FileReader(fname));
OutputStream ostream=sock.getOutputStream();
PrintWriter pwrite =new PrintWriter (ostream,true);
String msg;
System.out.println("Sending the contents of"+fname+"file");
while((msg=contentRead.readLine())!=null)
{
pwrite.println(msg);
}
sock.close();
}
}
