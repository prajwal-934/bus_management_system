package com.example.studentapp;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import java.sql.ResultSet;
import java.util.ArrayList;

public class BusList extends AppCompatActivity {
   ListView list;
   ArrayList<String> bus_no = new ArrayList<String>();
   ArrayList<String> routes = new ArrayList<String>();
   String qry;
   String selected_bus;
   ResultSet rs;
   Intent intent ;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_bus_list);
        getSupportActionBar().hide();
        list = findViewById(R.id.list);
        intent = new Intent(BusList.this,MapsActivity.class);
       qry="SELECT busno ,all_stops FROM routes r , bus_table b WHERE b.route_id = r.route_id AND b.isactive = 'true' and b.isalive ='alive'";
        try {
           rs= StudentDb.read(qry);
           while(rs.next())
           {
               bus_no.add(rs.getString(1));
               routes.add(rs.getString(2));
           }
        } catch (Exception e) {
            e.printStackTrace();
        }
        BusListAdapter adapter = new BusListAdapter(this,routes,bus_no);
        list.setAdapter(adapter);
        list.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                Toast.makeText(BusList.this, bus_no.get(i), Toast.LENGTH_SHORT).show();
                selected_bus = bus_no.get(i);
                intent.putExtra("selected_bus",selected_bus);
                startActivity(intent);
            }
        });

    }
}



class  BusListAdapter extends ArrayAdapter<String>{
    Context context;
    ArrayList<String> routes;
    ArrayList<String> bus_no;
    BusListAdapter(Context context , ArrayList<String> routes , ArrayList<String> bus_no){
        super(context,R.layout.single_row,R.id.textView2,routes);
        this.context = context;
        this.routes = routes;
        this.bus_no = bus_no;
    }

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        View row = convertView;
        if(convertView == null)
        {
            LayoutInflater layoutInflater = (LayoutInflater) context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            row = layoutInflater.inflate(R.layout.single_row,parent,false);
        }

        TextView busnotxt  = row.findViewById(R.id.textView);
        TextView routestxt  = row.findViewById(R.id.textView2);
        routestxt.setText(routes.get(position));
        busnotxt.setText(bus_no.get(position));


        return row;

    }
}