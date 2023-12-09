package com.example.swiftandroidexample;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {
    private TextView headerTV;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        try {
            // initializing swift runtime.
            // The first argument is a pointer to java context (activity in this case).
            // The second argument should always be false.
            org.swift.swiftfoundation.SwiftFoundation.Initialize(this, false);
        } catch (Exception err) {
            android.util.Log.e("SwiftAndroidExample", "Can't initialize swift foundation: " + err.toString());
        }

        // loading dynamic library containing swift code
        System.loadLibrary("SwiftAndroidExample");

        headerTV = (TextView) findViewById(R.id.headerTV);

        // call swift method from Java
        printHelloWorld();
    }

    public native void printHelloWorld();

    // method is called from swift code, and result is sent as input parameter
    public void printText(String validationResult) {
        headerTV.setText(validationResult);
    }


}