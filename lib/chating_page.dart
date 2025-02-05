import 'package:flutter/material.dart';

class ChatingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matches'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); // This takes the user back to HomePage
          },
          icon: Icon(Icons.home),
        ),
      ),
      body: const Center(
        child: Text('Welcome to Chat Page!'),
      ),
    );
  }
}

//   // Function to show exit confirmation dialog
//   void _showExitDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Exit Chat?"),
//         content: const Text("Do you really want to go back?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context), // Close dialog
//             child: const Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context); // Close dialog
//               Navigator.pop(context); // Go back to HomePage
//             },
//             child: const Text("Yes"),
//           ),
//         ],
//       ),
//     );
//   }
// }
