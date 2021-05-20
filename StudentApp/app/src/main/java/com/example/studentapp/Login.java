package com.example.studentapp;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.os.Bundle;

import android.content.Intent;

import android.text.method.LinkMovementMethod;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Login extends AppCompatActivity {
    Button loginbtn;
    EditText temail,tpassword;
    Intent dash_intent,app_offline;
    SharedPreferences prefs;
    String userid , name , pass ,useremail,rollno;
    ProgressDialog dialog;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);
        TextView register = (TextView)findViewById(R.id.lnkRegister);
        getSupportActionBar().hide();
        register.setMovementMethod(LinkMovementMethod.getInstance());

        temail = findViewById(R.id.txtEmail);
        tpassword = findViewById(R.id.txtPwd);
        loginbtn = findViewById(R.id.loginbtn);

        prefs = getSharedPreferences("user_details",MODE_PRIVATE);
        dash_intent = new Intent(Login.this,Dashboard.class);
        if(prefs.contains("userid")){
            startActivity(dash_intent);
        }



        loginbtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {


                String email, password;
            email = temail.getText().toString().trim();
            password = tpassword.getText().toString().trim();


            if(email.equals("")&&password.equals(""))
            {
                Toast.makeText(getApplicationContext(),"Insert",Toast.LENGTH_LONG).show();

            }
            else{
                dialog = ProgressDialog.show(Login.this,"","Loading please wait",true);

                boolean check = false;
                String qry ="SELECT * FROM `student` WHERE email ='"+email+"' AND password ='"+password+"'";
                ResultSet rs=null;
                try {
                    rs= StudentDb.read(qry);
                    if(rs.next())

                    if(rs.getString("isverified").equals("false"))
                    {
                        Toast.makeText(Login.this, "You are not verified yet", Toast.LENGTH_LONG).show();
                    }
                    else
                        rs.previous();
                    check = rs.next();


                } catch (Exception e) {

                    dialog.dismiss();
                }





                if(check) {

                    try {
                        userid = Integer.toString(rs.getInt("id"));
                        pass = rs.getString("password");
                        name = rs.getString("name");
                        useremail = rs.getString("email");
                        rollno = rs.getString("rollno");
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }

                    SharedPreferences.Editor editor = prefs.edit();
                    editor.putString("userid",userid);
                    editor.putString("pass",pass);
                    editor.putString("name",name);
                    editor.putString("useremail",useremail);
                    editor.putString("rollno",rollno);

                    editor.commit();
                    Toast.makeText(getApplicationContext(), "Login Successful",Toast.LENGTH_SHORT).show();
                    startActivity(dash_intent);

                }
                else if(StudentDb.is_server_on)
                {
                    Toast.makeText(getApplicationContext(),"Server is Off",Toast.LENGTH_LONG).show();
                    dialog.dismiss();
                }
                else{
                    dialog.dismiss();
                   // Toast.makeText(getApplicationContext(),"Invalid",Toast.LENGTH_LONG).show();
                }
            }



            }
        });


        register.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(Login.this, Registration.class);
                startActivity(intent);
            }
        });
    }
    @Override
    public void onBackPressed() {

        new AlertDialog.Builder(this)
                .setTitle("Really Exit?")
                .setMessage("Are you sure you want to exit?")
                .setNegativeButton(android.R.string.no, null)
                .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        Intent intent = new Intent(Intent.ACTION_MAIN);
                        intent.addCategory(Intent.CATEGORY_HOME);
                        startActivity(intent);
                    }
                }).create().show();
    }
}