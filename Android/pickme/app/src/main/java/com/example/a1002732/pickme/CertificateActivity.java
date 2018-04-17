package com.example.a1002732.pickme;

import android.app.Activity;
import android.os.Bundle;
import android.os.Environment;
import android.support.annotation.Nullable;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.Toast;

import com.kakao.auth.AuthType;
import com.kakao.auth.ErrorCode;
import com.kakao.auth.ISessionCallback;
import com.kakao.auth.KakaoSDK;
import com.kakao.auth.Session;
import com.kakao.network.ErrorResult;
import com.kakao.usermgmt.LoginButton;
import com.kakao.usermgmt.UserManagement;
import com.kakao.usermgmt.callback.MeResponseCallback;
import com.kakao.usermgmt.response.model.UserProfile;
import com.kakao.util.exception.KakaoException;

import util.FileUtil;

/**
 * Created by 1002732 on 2018. 4. 15..
 */

public class CertificateActivity extends Activity implements View.OnClickListener{
    final String DIR_PATH = "/Android/data/com.example.a1002732.pickme/";
    final String FILE_NAME = "propertie.txt";

    SessionCallback callback;

    LoginButton kakaoRealButton;

    Button button;
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.certificate);

        callback = new SessionCallback();
        Session.getCurrentSession().addCallback(callback);
    }


    @Override
    public void onClick(View v) {
        switch (v.getId()){

            case R.id.kakaoAssignBtn:

                break;
            default:
        }
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
                    Log.d("이준환", "onSuccess: sdsds");
                    Toast.makeText(getApplicationContext(),"",Toast.LENGTH_LONG).show();;
                }
            });

        }

        @Override
        public void onSessionOpenFailed(KakaoException exception) {

        }
    }




}
