package com.example.driverapp;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

import java.sql.ResultSet;

public class DriverProfile extends AppCompatActivity {

    TextView user,name,num,bus_no,routes;
    Button back;
    Intent dash;
    SharedPreferences prefs;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_driver_profile);
        getSupportActionBar().hide();
        user = findViewById(R.id.user);
        name = findViewById(R.id.name);
        bus_no = findViewById(R.id.bus);
        num = findViewById(R.id.number);
        routes = findViewById(R.id.routes);


        back = findViewById(R.id.backbtn);
        prefs = getSharedPreferences("user_details",MODE_PRIVATE);
        dash = new Intent(DriverProfile.this,Dashboard.class);

       String userid =prefs.getString("userid",null);
        try {
           ResultSet rs= Db.read("select all_stops,b.busno,d.name,d.phone from driver d, routes r, bus_table b where d.busno=b.busno and b.route_id = r.route_id AND d.userid='"+userid+"'");
            rs.next();
            user.setText("UserID : "+userid);
            name.setText("Name : "+rs.getString(3));
            num.setText("Contact : "+rs.getString(4));
            bus_no.setText("Bus No : "+rs.getString(2));
            routes.setText("ROUTES : \n"+rs.getString(1));


        } catch (Exception e) {
            e.printStackTrace();
        }
        back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                startActivity(dash);

            }
        });

    }


}