package com.example.studentapp;

import android.content.Intent;
import android.os.Bundle;

import android.text.method.LinkMovementMethod;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

/**
 * Created by tutlane on 08-01-2018.
 */

public class Registration extends AppCompatActivity {

    Button register;
    EditText tname , temail , tpassword, tcpassword , trollno;
    Intent login_intent;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_registration);
        TextView login = (TextView)findViewById(R.id.lnkLogin);
        getSupportActionBar().hide();
        //Registerbtn
        register = findViewById(R.id.loginbtn);
        tname = findViewById(R.id.txtName);
        temail = findViewById(R.id.txtEmail);
        tpassword = findViewById(R.id.txtPwd);
        tcpassword = findViewById(R.id.cPwd);
        trollno = findViewById(R.id.txtrollno);



        register.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                String name,email,password,cpassword,rollno;
                name = tname.getText().toString().trim();
                email = temail.getText().toString().trim();
                rollno = trollno.getText().toString().trim();
                password = tpassword.getText().toString().trim();
                cpassword = tcpassword.getText().toString().trim();
                Log.i("check var",name+email+password+cpassword+rollno);
                if((name.equals(""))&&(email.equals(""))&&(password.equals(""))&&cpassword.equals("")&&rollno.equals(""))
                {
                    Toast.makeText(getApplicationContext(),"All Fields are mandatory",Toast.LENGTH_LONG).show();
                }
                else{

                    login_intent = new Intent(Registration.this,Login.class);
                    if(password.equals(cpassword))
                    {
                        int check = 0;
                        check =   StudentDb.insertStudent(name,email,password,rollno);
                        Log.i("Bool" , Integer.toString(check));
                        if(check>0)
                             startActivity(login_intent);
                        else
                            Toast.makeText(getApplicationContext(),"Something went Wrong",Toast.LENGTH_LONG).show();

                    }
                    else
                    {
                        Toast.makeText(getApplicationContext(),"Password mismatch",Toast.LENGTH_LONG).show();

                    }

                }









            }
        });





















        login.setMovementMethod(LinkMovementMethod.getInstance());
        login.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(Registration.this, Login.class);
                startActivity(intent);
            }
        });
    }
}