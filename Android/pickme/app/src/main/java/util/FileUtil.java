package util;

import android.widget.Toast;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;

/**
 * Created by 1002732 on 2018. 4. 15..
 */

public class FileUtil {

    public String readFile(String path){
        String readStr = "";

        try{
            BufferedReader br = new BufferedReader(new FileReader(path));

            String str = null;
            while(((str = br.readLine()) != null)){
                readStr += str;
            }
            br.close();

        }catch (FileNotFoundException e){
            e.printStackTrace();
        }catch (IOException e) {
            e.printStackTrace();
        }
        return readStr;
    }

    public Boolean writeFile(File file, String text){
        FileOutputStream fos = null;

        try {
            fos = new FileOutputStream(file);
            fos.write(text.getBytes());
            fos.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }


        return true;
    }
}
