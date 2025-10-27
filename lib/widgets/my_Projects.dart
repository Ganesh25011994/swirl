import 'package:flutter/material.dart';

class MyProjects extends StatelessWidget {
  final List<Map<String, dynamic>> cardData;
  const MyProjects({super.key,required this.cardData});

  @override
  Widget build(BuildContext context) {
   print(cardData);
    return Center(
      child: Column(
        children: List.generate(cardData.length, (index) {
          var item = cardData[index];
          return Padding(
            padding: const EdgeInsets.only(
              right: 10,
              left: 0,
              bottom: 8,
              top: 0,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Circular avatar/icon
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey.shade300,
                      // optionally add icon or image here
                      child: Icon(
                        // Icons.account_circle,
                        item['icon'],
                        color: Colors.grey.shade600,
                        size: 32,
                      ),
                    ),
                    SizedBox(width: 12),

                    // Middle column: Title and Last Modified text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item["projectName"],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Last Modified: ${item["createdOn"]}",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(width: 8),

                    // Right side column with badge and icons
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Published badge
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            "Published",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        SizedBox(height: 12),

                        // Row of three icons
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 18,
                              color: Colors.grey.shade600,
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.notifications_none,
                              size: 18,
                              color: Colors.grey.shade600,
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.more_vert,
                              size: 18,
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // child: Card(
            //  child: ListTile(
            //   leading: Icon(item["icon"]),
            //   title: Text(item["projectName"]),
            //   subtitle: Text("ID - ${item["projectId"]}"),
            //   trailing: Text("Created On - ${item["createdOn"]}"),
            //  ),
            // ),
          );
        }),
      ),
    );
  }
}
