package com.example.studentapp;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;


import com.google.android.gms.location.places.Place;
import com.google.android.gms.location.places.ui.PlacePicker;

import java.sql.ResultSet;

public class Profile extends AppCompatActivity {
    SharedPreferences prf;
    TextView id,txt_name,txt_email,txt_password ,text_view, txt_roll;
    String name , email, password, rollup;
    Button bt_picker;
    int request =1;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_profile);
     getSupportActionBar().hide();
        prf = getSharedPreferences("user_details",MODE_PRIVATE);
       String  loginid = prf.getString("userid",null);
        id = findViewById(R.id.id);
        txt_name = findViewById(R.id.name);
        txt_email = findViewById(R.id.email);

        text_view =findViewById(R.id.text_view);
        txt_roll =(TextView) findViewById(R.id.roll);

        bt_picker = findViewById(R.id.bt_picker);
        id.setText(loginid);
        if(prf.contains("lat")){
            text_view.setText("Bus Stop Selected");
            text_view.setTextColor(getResources().getColor(R.color.green));

        }
        else{
            text_view.setText("Bus Stop Not Selected");
            text_view.setTextColor(getResources().getColor(R.color.red));
        }


        bt_picker.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                PlacePicker.IntentBuilder  builder = new PlacePicker.IntentBuilder();
                try {
                    startActivityForResult(builder.build(Profile.this),request);

                }catch (Exception e)
                {

                }
            }
        });

        int user_id = Integer.parseInt(loginid);
        try {
           ResultSet rs = StudentDb.read("SELECT * FROM student WHERE id ="+loginid+"");
           if(rs.next()) {
               name = rs.getString("name");
               email = rs.getString("email");
               password = rs.getString("password");
               rollup = rs.getString(6);
               Log.i("roll",rollup);
               txt_name.setText(name);
               txt_email.setText(email);
               txt_password.setText(password);
              // txt_roll.setText(rollup);
               txt_roll.setText("gdfgfdg");

               Log.i("db", name);
           }else{
               id.setText("error");
           }
        } catch (Exception e) {
            Log.i("db1" , e.getMessage());


        }


    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(requestCode == request){
            if(resultCode == RESULT_OK){
                Place place = PlacePicker.getPlace(data,this);
                String lat="",lng="";
                 lat = String.valueOf(place.getLatLng().latitude);
                 lng = String.valueOf(place.getLatLng().longitude);
                SharedPreferences.Editor editor = prf.edit();
                editor.putString("lat",lat);
                editor.putString("lng",lng);
                if(!lat.equals(""))
                {
                    text_view.setText("Bus Stop Selected");
                    text_view.setTextColor(getResources().getColor(R.color.green));
                }
                else{
                    text_view.setText("Bus Stop Not Selected");
                    text_view.setTextColor(getResources().getColor(R.color.red));
                }
                editor.commit();
            }

        }
    }
}