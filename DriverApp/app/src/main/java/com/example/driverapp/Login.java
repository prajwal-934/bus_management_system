package com.example.driverapp;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import java.sql.ResultSet;

public class Login extends AppCompatActivity {

    Button login_btn;
    String user_id;
    String password;
    EditText t1,t2;
    SharedPreferences prefs;
    Intent dash;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        getSupportActionBar().hide();

        t1 =(EditText)findViewById(R.id.user);
        t2 =(EditText)findViewById(R.id.password);
        login_btn = findViewById(R.id.login_btn);
        prefs = getSharedPreferences("user_details",MODE_PRIVATE);
        dash = new Intent(Login.this,Dashboard.class);
        if(prefs.contains("userid") && prefs.contains("password")){
            startActivity(dash);
        }

        login_btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                try {
                   user_id= t1.getText().toString().trim();
                   password= t2.getText().toString().trim();
                   if(user_id.matches("") && password.matches(""))
                   {
                       Toast.makeText(getApplicationContext(),"Please Enter your ID and password", Toast.LENGTH_LONG).show();
                   }
                   else
                   {
                       boolean check = false;
                       String qry="SELECT * FROM `driver` WHERE userid='"+user_id+"' AND password='"+password+"'";
                       ResultSet rs;
                       rs= Db.read(qry);
                       check = rs.next();



                       if(check)
                       {
                           String dbuserid = rs.getString("userid");
                           String dbpass = rs.getString("password");
                           String name = rs.getString("name");
                           SharedPreferences.Editor editor = prefs.edit();
                           editor.putString("userid",user_id);
                           editor.putString("password",password);
                           editor.putString("name",name);
                           editor.commit();
                           Toast.makeText(getApplicationContext(), "Login Successful",Toast.LENGTH_SHORT).show();
                           startActivity(dash);

                       }
                       else{
                           Toast.makeText(getApplicationContext(),"Invalid", Toast.LENGTH_LONG).show();

                       }
                   }

                } catch (Exception e) {
                   Log.i("","e.printStackTrace()");
                }
            }
        });


    }
}