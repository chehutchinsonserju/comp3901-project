import 'package:capstone/components/bottom_navigation_bar.dart';
import 'package:capstone/components/sentiment.dart';
import 'package:capstone/screens/journal.dart';
import 'package:capstone/style/app_style.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _textController = TextEditingController();
  List<Map<String, dynamic>> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: 2,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(
                context,
                '/journal',
              );
              break;
            case 1:
              Navigator.pushNamed(
                context,
                '/home',
              );
              break;
            case 2:
              Navigator.pushNamed(
                context,
                '/chat',
              );
              break;
          }
        },
      ),
      appBar: AppBar(
        backgroundColor: AppStyle.mainColor,
        centerTitle: true,
        title: Text(
          "Chat",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: _messages[index]['isSent']
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75),
                        decoration: BoxDecoration(
                          color: AppStyle.mainColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: _messages[index]['isSent']
                                ? Radius.circular(10)
                                : Radius.circular(0),
                            bottomRight: _messages[index]['isSent']
                                ? Radius.circular(0)
                                : Radius.circular(10),
                          ),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Column(
                          crossAxisAlignment: _messages[index]['isSent']
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Text(
                              _messages[index]['message'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              _messages[index]['time'],
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      hintText: "Write a message",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    if (_textController.text.isNotEmpty) {
                      setState(() {
                        _messages.add({
                          'message': _textController.text,
                          'time':
                              '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                          'isSent': true,
                        });
                        _textController.clear();
                      });
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: Color(0xFF1D9AAD),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
