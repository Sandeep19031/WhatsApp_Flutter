import 'package:flutter/material.dart';

class StatusScreen extends StatelessWidget {
  const StatusScreen({Key? key}) : super(key: key);

  final List<Map<String,Object>> recentUpdates = const  [
      {
        'imageUrl': 'https://upload.wikimedia.org/wikipedia/commons/7/7f/Emma_Watson_2013.jpg',
        'timestamp': '10:20',
        'name': 'Emma Watson'
      },
      {
        'imageUrl': 'https://upload.wikimedia.org/wikipedia/commons/7/7f/Emma_Watson_2013.jpg',
        'timestamp': '10:20',
        'name': 'Emma Watson'
      },
      {
        'imageUrl': 'https://upload.wikimedia.org/wikipedia/commons/7/7f/Emma_Watson_2013.jpg',
        'timestamp': '10:20',
        'name': 'Emma Watson'
      },
      {
        'imageUrl': 'https://upload.wikimedia.org/wikipedia/commons/7/7f/Emma_Watson_2013.jpg',
        'timestamp': '10:20',
        'name': 'Emma Watson'
      },
     
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
            child: Stack(
            children:[ ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/7/7f/Emma_Watson_2013.jpg'),
              ),
              title: Text('My status', 
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),
              ),
              subtitle: Text('Tap to add status update')
            ),
            Positioned(
                left: 60,
                top: 40,
                child: Container(
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(49),
                  color: Colors.green
                ),
                child: Icon(Icons.add, color: Colors.white, size: 18)
              ),
            ),
          ]
          ),
        ),
        Divider(
          height: 1,
          color: Colors.grey[400]
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          child: Text('Recent updates', 
            style: TextStyle(fontWeight: FontWeight.w600, color :Colors.grey[600]),

          ),
          color: Colors.grey[300]
        ),
        Expanded(
          flex: 2,
            child: ListView.builder(
            itemCount: recentUpdates.length,
            itemBuilder: (context,index) {
              return Column(
                children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/7/7f/Emma_Watson_2013.jpg'),
                    radius: 30,
                  ),
                  title: Text(recentUpdates[index]['name'] as String, 
                        style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(recentUpdates[index]['timestamp'] as String)
                ),
                Divider( color: Colors.grey, height: 1, indent: 80,)
              ]
              );
            }),
        ),
   
      Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            child: Text('Viewed updates', 
              style: TextStyle(fontWeight: FontWeight.w600, color :Colors.grey[600]),

            ),
            color: Colors.grey[300]
          ),
        
        Expanded(
          flex: 2,
            child: ListView.builder(
            itemCount: recentUpdates.length,
            itemBuilder: (context,index) {
              return Column(
                children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/7/7f/Emma_Watson_2013.jpg'),
                    radius: 30,
                  ),
                  title: Text(recentUpdates[index]['name'] as String, 
                        style: TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(recentUpdates[index]['timestamp'] as String)
                ),
                Divider( color: Colors.grey, height: 1, indent: 80,)
              ]
              );
            }),
        ),
      ],
    );
  }
}