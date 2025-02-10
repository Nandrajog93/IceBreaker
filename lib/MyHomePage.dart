import 'package:flutter/material.dart';
import 'chating_page.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  bool isGrid = true;
  List<String> nearest_match = ['Sara', 'Anna', 'Sehar', 'Sophia', 'Emma'];
  List<String> distance = ['1', '2', '3', '4', '5'];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Nearest matches'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.list : Icons.grid_view), // Toggle icon
            onPressed: () {
              setState(() {
                isGrid = !isGrid; // Toggle between Grid and List
              });
            },
          ),
        ],
      ),
      body: buidList(),
    );
  }

  Widget buidList() => isGrid
      ? GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: nearest_match.length,
          itemBuilder: (context, index) {
            final item = nearest_match[index];

            return GridTile(
              child: InkWell(
                child: Ink.image(
                  image: NetworkImage(
                      'https://picsum.photos/id/870/200/300?grayscale&blur=2'),
                  fit: BoxFit.cover,
                ),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatingPage())),
              ),
              footer: Container(
                padding: EdgeInsets.all(12),
                alignment: Alignment.center,
                child: Text(
                  item,
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            );
          },
        )
      : ListView.builder(
          itemCount: nearest_match.length,
          itemBuilder: (context, index) {
            final item = nearest_match[index];
            final item2 = distance[index];
            return ListTile(
                leading: const CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(
                      'https://picsum.photos/id/870/200/300?grayscale&blur=2'),
                ),
                title: Text(item),
                subtitle: Text(item2 + ' kms away'),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatingPage())));
          });
}
