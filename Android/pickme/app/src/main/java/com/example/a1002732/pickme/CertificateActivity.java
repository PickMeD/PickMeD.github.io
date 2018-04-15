package com.example.a1002732.pickme;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.os.Environment;
import android.support.annotation.Nullable;
import android.util.Log;
import com.facebook.CallbackManager;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.FacebookSdk;
import com.facebook.appevents.AppEventsLogger;
import com.facebook.login.LoginManager;
import com.facebook.login.LoginResult;
import com.facebook.login.widget.LoginButton;
import com.kakao.auth.ErrorCode;
import com.kakao.auth.ISessionCallback;
import com.kakao.auth.Session;
import com.kakao.network.ErrorResult;
import com.kakao.usermgmt.UserManagement;
import com.kakao.usermgmt.callback.MeResponseCallback;
import com.kakao.usermgmt.response.model.UserProfile;
import com.kakao.util.exception.KakaoException;

import util.FileUtil;

/**
 * Created by 1002732 on 2018. 4. 15..
 */

public class CertificateActivity extends Activity {
    final String DIR_PATH = "/Android/data/com.example.a1002732.pickme/";
    final String FILE_NAME = "propertie.txt";

    private CallbackManager callbackManager;


    LoginButton facebook_login;
    SessionCallback callback;


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.certificate);

        callback = new SessionCallback();
        Session.getCurrentSession().addCallback(callback);



        FacebookSdk.sdkInitialize(getApplicationContext());
        AppEventsLogger.activateApp(this);
        callbackManager = CallbackManager.Factory.create();

        facebook_login = findViewById(R.id.login_button);

        facebook_login.setReadPermissions("email");

        LoginManager.getInstance().registerCallback(callbackManager,
                new FacebookCallback<LoginResult>() {
                    @Override
                    public void onSuccess(LoginResult loginResult) {
                        // App code
                        Log.d("PickMe Exception","onSucces LoginResult="+loginResult);
                    }

                    @Override
                    public void onCancel() {
                        // App code
                        Log.d("PickMe Exception","onCancel");
                    }

                    @Override
                    public void onError(FacebookException exception) {
                        // App code
                        Log.e("페북에러" , exception.toString());
                    }
                });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        callbackManager.onActivityResult(requestCode, resultCode, data);
    }



    public void metainfoSave(String Type, String id){
        FileUtil fileUtil = new FileUtil();
        String res = fileUtil.readFile(Environment.getExternalStorageDirectory().getAbsolutePath()+DIR_PATH+FILE_NAME);

        String msg = "{\"type\":\"\",\"value\":\"\",\"privatekey\":\"\",\"account\":\"\",\"procstatus\":\"INIT\",\"index\":\"\"}";
    }



    private class SessionCallback implements ISessionCallback {

        @Override
        public void onSessionOpened() {

            UserManagement.requestMe(new MeResponseCallback() {

                @Override
                public void onFailure(ErrorResult errorResult) {
                    String message = "failed to get user info. msg=" + errorResult;

                    ErrorCode result = ErrorCode.valueOf(errorResult.getErrorCode());
                    if (result == ErrorCode.CLIENT_ERROR_CODE) {
                        //에러로 인한 로그인 실패
//                        finish();
                    } else {
                        //redirectMainActivity();
                    }
                }

                @Override
                public void onSessionClosed(ErrorResult errorResult) {
                }

                @Override
                public void onNotSignedUp() {

                }

                @Override
                public void onSuccess(UserProfile userProfile) {
                    //로그인에 성공하면 로그인한 사용자의 일련번호, 닉네임, 이미지url등을 리턴합니다.
                    //사용자 ID는 보안상의 문제로 제공하지 않고 일련번호는 제공합니다.
                    long number = userProfile.getId();
                }
            });

        }

        @Override
        public void onSessionOpenFailed(KakaoException exception) {

        }
    }




}
