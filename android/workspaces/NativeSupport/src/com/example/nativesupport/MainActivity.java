package com.example.nativesupport;

import android.app.Activity;
import android.app.AlertDialog;
import android.os.Bundle;
import android.view.Menu;

public class MainActivity extends Activity {
    // load the library - name matches jni/Android.mk
    static {
      System.loadLibrary("NativeSupport");
    }

    // declare the native code function - must match ndkfoo.c
    private native String invokeNativeFunction();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // this is where we call the native code
        String hello = invokeNativeFunction();
        new AlertDialog.Builder(this).setMessage(hello).show();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

}
