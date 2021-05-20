package com.example.studentapp;

import androidx.fragment.app.FragmentActivity;

import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Handler;
import android.os.StrictMode;
import android.util.Log;
import android.widget.Toast;

import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.SupportMapFragment;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class MapsActivity extends FragmentActivity implements OnMapReadyCallback {

    private GoogleMap mMap;
    String busno;
    SharedPreferences prf;
    Handler handler = new Handler();
    Marker m ;

    boolean flag=true;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_maps);
        // Obtain the SupportMapFragment and get notified when the map is ready to be used.
        SupportMapFragment mapFragment = (SupportMapFragment) getSupportFragmentManager()
                .findFragmentById(R.id.map);
        mapFragment.getMapAsync(this);
       busno = getIntent().getStringExtra("selected_bus");
    }

    /**
     * Manipulates the map once available.
     * This callback is triggered when the map is ready to be used.
     * This is where we can add markers or lines, add listeners or move the camera. In this case,
     * we just add a marker near Sydney, Australia.
     * If Google Play services is not installed on the device, the user will be prompted to install
     * it inside the SupportMapFragment. This method will only be triggered once the user has
     * installed Google Play services and returned to the app.
     */
    @Override
    public void onMapReady(GoogleMap googleMap) {
        mMap = googleMap;
        prf = getSharedPreferences("user_details",MODE_PRIVATE);
        String stoplat="" , stoplng="";
          stoplat = prf.getString ("lat",null);
          stoplng = prf.getString("lng",null);
        if(!(stoplat.equals("")&&stoplng.equals(""))) {
            Toast.makeText(this, "value", Toast.LENGTH_SHORT).show();

            double dlat = Double.parseDouble(stoplat);
            double dlng = Double.parseDouble(stoplng);
            Log.i("Latlng", stoplat + " , " + stoplng);
            //  Add a marker in Sydney and move the camera
            LatLng bustop = new LatLng(dlat, dlng);
            MarkerOptions marker = new MarkerOptions();
            marker.icon(BitmapDescriptorFactory.fromResource(R.drawable._icon));
            mMap.addMarker(marker.position(bustop).title("Your Bus Stop"));
//
        }
        MarkerOptions clgmarker = new MarkerOptions();
        clgmarker.icon(BitmapDescriptorFactory.fromResource(R.drawable.college));
        LatLng college = new LatLng(22.5978,75.7873);
        mMap.addMarker(clgmarker.position(college).title("Sushila Devi Bansal College"));


        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                handler.postDelayed(this,5000);
                getLatLongFromDb();
            }
        },5000);
    }


    void addmarker(double lat , double lng)
    {
        if(m!=null)
        {
            m.remove();
        }
        MarkerOptions busmarker = new MarkerOptions();
        busmarker.icon(BitmapDescriptorFactory.fromResource(R.drawable.bus));
        LatLng sydney = new LatLng(lat, lng);
        m=mMap.addMarker(busmarker.position(sydney).title(busno));
        if(flag)
        {
            mMap.animateCamera(CameraUpdateFactory.newLatLngZoom(sydney,16));
            flag=false;
        }
        else
        mMap.animateCamera(CameraUpdateFactory.newLatLng(sydney));
    }

    public  void getLatLongFromDb()
    {
        String location = "error";


        try{
           StudentDb.connectDB();
            ResultSet rs = StudentDb.st.executeQuery("SELECT current_lat,current_lng FROM `bus_table` WHERE `busno` = '"+busno+"'");
            rs.next();
            String lat = rs.getString(1);
            String longi = rs.getString(2);
            addmarker(rs.getDouble(1),rs.getDouble(2));
            location = lat+","+longi;



//            Log.i("Db",location);


        }
        catch (Exception e)
        {
            Log.i("ex", String.valueOf(e));
        }


    }
}