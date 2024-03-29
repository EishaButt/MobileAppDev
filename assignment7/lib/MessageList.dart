import 'package:assignment7/ComposeButton.dart';
import 'package:assignment7/Message.dart';
import 'package:assignment7/MessageDetail.dart';
import 'package:assignment7/RegisterForm.dart';
import 'package:flutter/material.dart';

class MessageList extends StatefulWidget {
  final String title;

  const MessageList({Key key, this.title}) : super(key: key);

@override
State<StatefulWidget> createState()=> _MessageListState();
}

class _MessageListState extends State<MessageList>{
 Future <List<Message>> future ;
 List<Message> messages = [];


 void initState(){
  super.initState();

  fetch();
 }

 void fetch() async{
   future = Message.browse();
    messages = await future;
 }


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
           IconButton(icon: Icon(Icons.app_registration), 
           onPressed: () async{
           Navigator.push(
          context, 
         MaterialPageRoute(
                  builder: (BuildContext context)=> RegisterForm()));
           }
           ),
            
          IconButton(icon: Icon(Icons.refresh), 
          onPressed: () async{
            var _messages = await Message.browse();

            setState(() {
              messages = _messages;
            });
          }),
        ],
      ),
      
       body: FutureBuilder(
         future: future,
         builder:(BuildContext context, AsyncSnapshot snapshot) {
           switch (snapshot.connectionState) {
             case ConnectionState.none:
             case ConnectionState.waiting:
             case ConnectionState.active:
             return Center(child: CircularProgressIndicator());
             case ConnectionState.done:
             if(snapshot.hasError) return Text ("There was an error: ${snapshot.error}");
             var messages = snapshot.data;
           return ListView.separated(
               itemCount: messages.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (BuildContext context ,int index){
           Message message = messages[index];

           return ListTile(
              title: Text(message.subject),
              isThreeLine: true,
            // trailing: Text('A'),
              leading: CircleAvatar(
                child: Text('PJ'),
              ),
              subtitle: Text(
              message.body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              ),
              onTap: (){
                Navigator.push(context, 
                MaterialPageRoute(
                  builder: (BuildContext context)=> 
                  MessageDetail(
                    message.subject,
                    message.body,
                  ),
                  )
                  );
              },
              
           );
            
         },
      );
           }
         },
         ),
          floatingActionButton: ComposeButton(messages),
           
    );
  }
}