import 'package:capstone/components/bottom_navigation_bar.dart';
import 'package:capstone/screens/journal.dart';
import 'package:capstone/style/app_style.dart';
import 'package:capstone/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:dialogflow_grpc/dialogflow_grpc.dart';
import 'package:dialogflow_grpc/generated/google/cloud/dialogflow/v2beta1/session.pb.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

late DialogflowGrpcV2Beta1 dialogflow;
late String sessionId;

class ChatScreen extends StatefulWidget {
  final String? message;
  const ChatScreen({Key? key, this.message}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  User? _user;


  bool _showInfo = true;
  String _infoMessage = "Start Chatting";
  MaterialColor _color = Colors.blue;

  @override
  void initState() {
    super.initState();
    initPlugin();
    if(widget.message != null){
      handleSubmitted(widget.message);
    }
  }

  Future<void> initPlugin() async {

    // TODO Get a Service account
    // Get a Service account
    final serviceAccount = ServiceAccount.fromString(
        '${(await rootBundle.loadString('assets/credentials.json'))}');
    // Create a DialogflowGrpc Instance
    dialogflow = DialogflowGrpcV2Beta1.viaServiceAccount(serviceAccount);

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    _user = FirebaseAuth.instance.currentUser;

}

  void handleSubmitted(text) async{
    print(text);
    _textController.clear();
    _user = FirebaseAuth.instance.currentUser;


    var snapshot = await FirebaseFirestore.instance.collection('response').orderBy('timestamp', descending: true).limit(5).get();
    double sum = 0;
    int count = 0;
    for (var doc in snapshot.docs) {
      var data = doc.data();

      if(data['client_id']==_user?.uid){
        var sentimentScore = data['sentimentscore'];
        sum += sentimentScore;
        count++;

      }
    }
    double average = count > 0 ? sum/count : 0;

    if (average >= 0.3) {
      setState(() {
        _color = Colors.lightGreen;
        _infoMessage = "Recent Mood: Positive \n" + "Average Score: " + average.toStringAsFixed(2);
      });
    }else if(average <=-0.3){
      _color = Colors.red;
      _infoMessage = "Recent Mood: Negative \n" + "Average Score: " + average.toStringAsFixed(2);
    }else{
      _color = Colors.lightBlue;
      _infoMessage = "Recent Mood: Neutral \n" + "Average Score: " + average.toStringAsFixed(2);
    }

    ChatMessage message = ChatMessage(
      text: text,
      name: _user?.displayName ?? "You",
      type: true,
    );

    setState(() {
      _messages.insert(0, message);
    });

    DetectIntentResponse data = await dialogflow.detectIntent(text, 'en-US');
    String fulfillmentText = data.queryResult.fulfillmentText;
    if(fulfillmentText.isNotEmpty) {
      ChatMessage botMessage = ChatMessage(
        text: fulfillmentText,
        name: "MindSpace",
        type: false,
      );

      setState(() {
        _messages.insert(0, botMessage);
      });

      _user = FirebaseAuth.instance.currentUser;
      CollectionReference collRef = FirebaseFirestore.instance.collection('response');
      collRef.add({
        'client_id': _user?.uid,
        'responseText': data.queryResult.queryText,
        'sentimentscore':data.queryResult.sentimentAnalysisResult.queryTextSentiment.score,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: 2,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => JournalScreen()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatScreen()),
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
      body: Column(children: <Widget>[
        Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            )),
        Divider(height: 1.0),
        Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: IconTheme(
              data: IconThemeData(color: Theme.of(context).accentColor),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: TextField(
                        controller: _textController,
                        onSubmitted: handleSubmitted,
                        decoration: InputDecoration.collapsed(hintText: "Send a message"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () => handleSubmitted(_textController.text),
                      ),
                    ),
                  ],
                ),
              ),
            )
        ),
    // Floating widget for displaying info
    Positioned(
    top: 10.0,
    right: 10.0,
    child: AnimatedOpacity(
    duration: Duration(milliseconds: 200),
    opacity: _showInfo ? 1.0 : 0.0,
    child: Container(
    decoration: BoxDecoration(
    color: _color,
    borderRadius: BorderRadius.circular(8.0),
    ),
    padding: EdgeInsets.all(8.0),
    child: Text(
    _infoMessage,
    style: TextStyle(color: Colors.white),
    ),
    ),
    ))]),
    );
  }

}

class ChatMessage extends StatelessWidget {
  ChatMessage({required this.text, required this.name, required this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      new Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar( backgroundImage: AssetImage('assets/images/logo.png'),
        backgroundColor: Colors.grey,),
      ),
      new Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(this.name,
                style: TextStyle(fontWeight: FontWeight.bold)),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(text),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Text(this.name, style: Theme.of(context).textTheme.subtitle1),
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: Text(text),
            ),
          ],
        ),
      ),
      Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: CircleAvatar(
            child: Text(
              this.name[0],
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}