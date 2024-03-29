import 'package:assignment7/Message.dart';
import 'package:flutter/material.dart';

class MessageCompose extends StatefulWidget {
  @override
  _MessageComposeState createState() => _MessageComposeState();
}

class _MessageComposeState extends State<MessageCompose> {
 String to = "";
 String subject = "";
 String body = "";

 final _key = GlobalKey<FormState>();
  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Compose New Message"),
      ),
      body:  SingleChildScrollView(
        child: Form (
          key: _key,
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title : TextFormField(
                 onSaved: (value)=> to = value,
             decoration: InputDecoration(
              labelText: 'TO',
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              )
            ),
          ),
            ),
         
          ListTile(
              title : TextFormField(
                 onSaved: (value) =>
                    subject = value,

             decoration: InputDecoration(
              labelText: 'SUBJECT',
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              )
            ),
          ),
            ),
          Divider(),
          ListTile(
              title : TextFormField(
                onSaved: (value) => body = value,
            decoration: InputDecoration(
              labelText: 'BODY',
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              )
            ),
            maxLines: 9,
          ),
          ),
           ListTile(
              title : RaisedButton(
                child: Text('SEND'),
                onPressed: () {
                   this._key.currentState.save();

                 Message message = Message(subject, body);
                 
                 Navigator.pop(context,message);
                  print(to);
                  print(subject);
                  print(body);
                   
                      }
                )
          )
         ],
         )
        ),
      )
    );
  }
}
