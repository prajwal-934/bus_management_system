package com.example.studentapp;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;

import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import java.sql.Connection;
import java.sql.SQLException;

public class Dashboard extends AppCompatActivity {

    SharedPreferences prf;
    CardView profile,logout,track,aboutus,contactus;
    String email,password,name,loginid;
    Intent logout_intent,about,profile_intent,error_page , bus_list;
    private static final String TAG = "Dashboard";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_dashboard);
        getSupportActionBar().hide();
        prf = getSharedPreferences("user_details",MODE_PRIVATE);
         loginid = prf.getString("userid",null);
         email = prf.getString("useremail",null);
         name = prf.getString("name",null);
         password = prf.getString("pass",null);
        contactus = findViewById(R.id.contactus);

        logout = findViewById(R.id.logout);
        track = findViewById(R.id.track);
        aboutus = findViewById(R.id.aboutus);
        profile = findViewById(R.id.profile);
        logout_intent = new Intent(Dashboard.this,Login.class);
        bus_list = new Intent(Dashboard.this,BusList.class);

        profile_intent =new Intent(Dashboard.this,Profile.class);
        about  = new Intent(Dashboard.this,AboutUS.class);


//profile
profile.setOnClickListener(new View.OnClickListener() {
    @Override
    public void onClick(View view) {
          startActivity(profile_intent);
    }
});




        //logout
        logout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                AlertDialog.Builder builder = new AlertDialog.Builder(Dashboard.this);
                builder.setTitle("Logout")
                        .setMessage("Are you sure, you want to Logout ?")
                        .setNegativeButton(android.R.string.no, null)
                        .setPositiveButton("Yes", new DialogInterface.OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialog, int which) {
                                SharedPreferences.Editor editor = prf.edit();
                                editor.clear();
                                editor.commit();
                                startActivity(logout_intent);

                            }
                        });

                builder.setNegativeButton("Cancel", null);
                AlertDialog dialog  = builder.create();
                dialog.show();


            }
        });


       track.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                if(prf.contains("lat")&&prf.contains("lng")) {

                    startActivity(bus_list);
                }
                else{
                    AlertDialog.Builder builder = new AlertDialog.Builder(Dashboard.this);
                    builder.setTitle("Select Bus stop")
                            .setMessage("You have not selected any bus stop location. Click OK to select")
                            .setNegativeButton(android.R.string.no, null)
                            .setPositiveButton("OK", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialog, int which) {

                                    startActivity(profile_intent);

                                }
                            });

                    builder.setNegativeButton("Cancel", null);
                    AlertDialog dialog  = builder.create();
                    dialog.show();

                }

            }
        });



        //about us
        aboutus.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                startActivity(about);

            }
        });
















    //contactus
    contactus.setOnClickListener(new View.OnClickListener() {
        @Override
        public void onClick(View view) {
            Intent intent = new Intent(Intent.ACTION_VIEW);
            intent.setData(Uri.parse("http://api.whatsapp.com/send?phone=+919340294054&text=Hi, i am bus world user"));
            startActivity(intent);
        }
    });



    }













    //back pressed
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