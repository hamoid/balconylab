import java.net.*;
import java.util.Enumeration;

int findMyID() {  
  Enumeration e = null;
  try {
    e=NetworkInterface.getNetworkInterfaces();
  } 
  catch(SocketException ex) {
    println(ex);
  }
  while (e.hasMoreElements ()) {
    NetworkInterface n=(NetworkInterface) e.nextElement();
    Enumeration ee = n.getInetAddresses();
    while (ee.hasMoreElements ()) {
      InetAddress i = (InetAddress) ee.nextElement();
      String host = i.getHostAddress();
      if (host.startsWith("192.168.")) {
        return(int(host.substring(1+host.lastIndexOf("."))));
      }
    }
  }
  return 0;
}

