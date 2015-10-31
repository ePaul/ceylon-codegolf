package codegolf.cat62230;

import java.io.IOException;

public class CatInJava {

    public static void cat() throws IOException {
        final byte[] a = new byte[1];
        while (0 < System.in.read(a)) {
            System.out.write(a);
        }
    }
}
