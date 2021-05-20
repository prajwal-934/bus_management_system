package com.example.driverapp;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.cardview.widget.CardView;

import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.CompoundButton;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;

public class Dashboard extends AppCompatActivity {
    SharedPreferences prf;
    Intent login;

    CardView profile,logout,contactus,aboutus;
    ToggleButton location;
    Intent logout_intent,about;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_dashboard);
        getSupportActionBar().hide();
        profile = findViewById(R.id.profile);
        location = findViewById(R.id.track);
        aboutus = findViewById(R.id.aboutus);
      logout = (CardView) findViewById(R.id.logout_btn);
        contactus = findViewById(R.id.contactus);
        prf = getSharedPreferences("user_details",MODE_PRIVATE);
        logout_intent = new Intent(Dashboard.this,Login.class);
        about  = new Intent(Dashboard.this,AboutUS.class);






    //profile
        profile.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent profile=new Intent(Dashboard.this,DriverProfile.class);
                startActivity(profile);

            }
        });

        //location Tracking
        location.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if (isChecked) {

                    
                    Toast.makeText(getApplicationContext(),"location is on",Toast.LENGTH_SHORT).show();


                } else {
                    Toast.makeText(getApplicationContext(),"location is off",Toast.LENGTH_SHORT).show();


                }
            }
        });






        logout.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                AlertDialog.Builder builder = new AlertDialog.Builder(Dashboard.this);
                builder.setTitle("Logout")
                        .setMessage("Are you sure, you want to Logout ?")
                        .setCancelable(false)
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



        //contactus
        //contactus
        contactus.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(Intent.ACTION_VIEW);
                intent.setData(Uri.parse("http://api.whatsapp.com/send?phone=+917470984274&text=Hi, i am bus world user"));
                startActivity(intent);
            }
        });


        //aboutus
        aboutus.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                startActivity(about);

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