package com.example.a1002732.pickme;

import android.Manifest;
import android.annotation.TargetApi;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Environment;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Toast;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import util.FileUtil;

public class MainActivity extends AppCompatActivity {

    private static final String TAG = "AppPermission";
    private final int MY_PERMISSION_REQUEST_STORAGE = 100;

    final String INIT_USER = "INIT";
    final String CERTED_JUST_USER = "CERT";
    final String PLAY_USER = "PLAY";


    FileUtil fileUtil = null;


    final String DIR_PATH = "/Android/data/com.example.a1002732.pickme/";
    final String FILE_NAME = "propertie.txt";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_main);


        fileUtil = new FileUtil();
        checkPermission();

        JSONObject metaJson = getMetaJson();
        String procStatus = "";
        try {
            procStatus = metaJson.getString("procstatus");
        } catch (JSONException e) {
            e.printStackTrace();
        }

        switch (procStatus){

            case INIT_USER:

                Intent intent  = new Intent(getApplicationContext(),CertificateActivity.class);
                intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                startActivity(intent);
                finish();
                break;
            case CERTED_JUST_USER:
                Intent intent2  = new Intent(getApplicationContext(),PasswordActivity.class);
                intent2.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                startActivity(intent2);
                finish();
                break;
            case PLAY_USER:
                Intent intent3 = new Intent(getApplicationContext(),PickMeActivity.class);
                intent3.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
                startActivity(intent3);
                finish();
                break;
            default:
        }
    }
    private void startLoading() {
        Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                finish();
            }
        }, 2000);
    }
    @Override
    protected void onResume() {
        super.onResume();



    }

    private JSONObject getMetaJson(){

        String res = fileUtil.readFile(Environment.getExternalStorageDirectory().getAbsolutePath()+DIR_PATH+FILE_NAME);

        JSONObject json = null;

        try {
            json = new JSONObject(res);

        } catch (JSONException e) {
            Log.d("PickMe Exception", e.getMessage());
            e.printStackTrace();
        }

        return json;
    }



    private boolean initProc(){
        String ess = Environment.getExternalStorageState();
        String sdCardPath = null;
        if(ess.equals(Environment.MEDIA_MOUNTED)) {
            sdCardPath = Environment.getExternalStorageDirectory().getAbsolutePath()+DIR_PATH;
        } else {
            return false;
        }

        try {
            File dir = new File(sdCardPath);
            if(!dir.exists()) dir.mkdir();
            File file = new File(sdCardPath + FILE_NAME);

            //파일이 존재하지 않으면 초기 파일을 생성
            if(!file.exists()){
                file.createNewFile();
                String msg = "{\"type\":\"kakao\",\"value\":\"niipoong\",\"privatekey\":\"b22563a7e548bf55fb6b230ef1733cd16f9b9a900a68c3258a0e922547a621c3\",\"account\":\"0xCB3f76FAb25c223653a85513D2ca42BAB68D1B21\",\"procstatus\":\"PLAY\",\"index\":\"\"}";
                boolean writeStatus = fileUtil.writeFile(file,msg);

                if(!writeStatus) return false;
            }
        } catch(FileNotFoundException fnfe) {
            Log.d("PickMe Exception", fnfe.getMessage());
        } catch(IOException ioe) {
            Log.d("PickMe Exception", ioe.getMessage());
        }

        return true;
    }

    @TargetApi(Build.VERSION_CODES.M)
    private boolean checkPermission() {
        if (checkSelfPermission(Manifest.permission.WRITE_EXTERNAL_STORAGE)
                != PackageManager.PERMISSION_GRANTED
                || checkSelfPermission(Manifest.permission.READ_EXTERNAL_STORAGE)
                != PackageManager.PERMISSION_GRANTED) {
            if (shouldShowRequestPermissionRationale(Manifest.permission.WRITE_EXTERNAL_STORAGE)) {
                Toast.makeText(this, "Read/Write external storage", Toast.LENGTH_SHORT).show();
            }

            requestPermissions(new String[]{Manifest.permission.READ_EXTERNAL_STORAGE, Manifest.permission.WRITE_EXTERNAL_STORAGE},
                    MY_PERMISSION_REQUEST_STORAGE);

        } else {
            return initProc();
        }
        return true;
    }
    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        switch (requestCode) {
            case MY_PERMISSION_REQUEST_STORAGE:
                if (grantResults[0] == PackageManager.PERMISSION_GRANTED
                        && grantResults[1] == PackageManager.PERMISSION_GRANTED) {

                    initProc();

                } else {
                    Log.d(TAG, "Permission always deny");
                }
                break;
        }
    }

}
