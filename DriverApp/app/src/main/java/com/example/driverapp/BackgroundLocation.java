package com.example.driverapp;

import android.Manifest;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationManager;
import android.os.IBinder;
import android.os.StrictMode;
import android.provider.Settings;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;
import androidx.core.app.NotificationCompat;

import com.google.android.gms.location.FusedLocationProviderClient;
import com.google.android.gms.location.LocationCallback;
import com.google.android.gms.location.LocationRequest;
import com.google.android.gms.location.LocationResult;
import com.google.android.gms.location.LocationServices;

import java.sql.DriverManager;
import java.sql.Statement;

public class BackgroundLocation extends Service {
    private static final int PERMISSIONS_REQUEST = 100;
    FusedLocationProviderClient client;

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    public void onCreate() {
        Toast.makeText(this, "Service was Created", Toast.LENGTH_LONG).show();
    }


    public int onStartCommand(Intent intent, int flags, int startId) {

       startTrackerService();

        Toast.makeText(this, "Service Started", Toast.LENGTH_LONG).show();
        return START_STICKY;
    }

    public void onDestroy() {
        super.onDestroy();
        // Stopping the player when service is destroyed
        stopLocation();

    }

    public void stopLocation()
    {
        client.removeLocationUpdates(mLocationCallback);
    }

    private void getLastLocation() {
        // check if permissions are given
        if (checkPermissions()) {

            // check if location is enabled
            if (isLocationEnabled()) {

                startTrackerService();
            } else {
                Toast.makeText(this, "Please turn on" + " your location...", Toast.LENGTH_LONG).show();
                Intent intent = new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS);
                startActivity(intent);
            }

        } else {
//            requestPermissions();
        }
    }


    public LocationCallback mLocationCallback = new LocationCallback() {

        @Override
        public void onLocationResult(LocationResult locationResult) {
            Location mLastLocation = locationResult.getLastLocation();
            Location location = locationResult.getLastLocation();

            if (location != null) {

//Save the location data to the database//

                //ref.setValue(location);

                String lati = Double.toString(location.getLatitude());
                String longi = Double.toString(location.getLongitude());
                showNotification(lati , longi);

               // saveInDataBase(lati,longi);

                Log.i("lat , long", lati + " , " + longi);
            } else {

                Intent intent = new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS);
                startActivity(intent);
            }
        }
    };


    public void startTrackerService() {
        LocationRequest request = new LocationRequest();

        request.setInterval(1000);

//Get the most accurate location data available//

        request.setPriority(LocationRequest.PRIORITY_HIGH_ACCURACY);
        client = LocationServices.getFusedLocationProviderClient(this);
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            // TODO: Consider calling
            //    ActivityCompat#requestPermissions
            // here to request the missing permissions, and then overriding
            //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
            //                                          int[] grantResults)
            // to handle the case where the user grants the permission. See the documentation
            // for ActivityCompat#requestPermissions for more details.
            return;
        }
        client.requestLocationUpdates(request, mLocationCallback, null);





    }

    public void showNotification(String lat , String longi)
    {
        NotificationCompat.Builder mBuilder =  new NotificationCompat.Builder(BackgroundLocation.this)
                .setSmallIcon(R.drawable.ic_launcher_foreground)
                .setContentTitle("Tutlane Send New Message")
                .setContentText("Latitude : "+lat+" Longitutde : "+longi+"");



        Intent resultIntent = new Intent(BackgroundLocation.this, Dashboard.class);
        PendingIntent pendingIntent = PendingIntent.getActivity(BackgroundLocation.this, 0, resultIntent, 0);
        mBuilder.setContentIntent(pendingIntent);
        
        // Sets an ID for the notification
        int mNotificationId = 001;
        NotificationManager notificationManager = (NotificationManager) getSystemService(NOTIFICATION_SERVICE);
        // It will display the notification in notification bar
        notificationManager.notify(mNotificationId, mBuilder.build());

    }













    //check permissions
// method to check for permissions
    private boolean checkPermissions() {
        return ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) == PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) == PackageManager.PERMISSION_GRANTED;

        // If we want background location
        // on Android 10.0 and higher,
        // use:
        // ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_BACKGROUND_LOCATION) == PackageManager.PERMISSION_GRANTED
    }

    // method to request for permissions
//    private void requestPermissions() {
//                ActivityCompat.requestPermissions( , new String[]{
//                Manifest.permission.ACCESS_COARSE_LOCATION,
//                Manifest.permission.ACCESS_FINE_LOCATION}, PERMISSIONS_REQUEST);
//    }

    // method to check
    // if location is enabled
    private boolean isLocationEnabled() {
       LocationManager locationManager = (LocationManager) getSystemService(Context.LOCATION_SERVICE);
        return locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER) || locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER);
    }

    public void saveInDataBase(String lat,String longi)
    {
        try{
            StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder().permitAll().build();
            StrictMode.setThreadPolicy(policy);
            Class.forName("com.mysql.jdbc.Driver");
            Statement stmt= DriverManager.getConnection("jdbc:mysql://192.168.43.46/test","abc","abc").createStatement();
            stmt.executeUpdate("UPDATE `position` SET lat='"+lat+"',lon = '"+longi+"' WHERE bud_id = 12");

        }
        catch (Exception e)
        {
            Log.i("ex", String.valueOf(e));
        }
    }



}
