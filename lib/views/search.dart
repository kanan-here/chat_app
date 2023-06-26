import 'package:chat_app/views/converstion_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/widget.dart';
import '../helper/constants.dart';

class SearchScreen extends StatefulWidget {
static String id='SearchScreen';
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}
class _SearchScreenState extends State<SearchScreen> {
  DatabaseMethods databaseMethods=new DatabaseMethods();
  TextEditingController searchTextEditingController =new TextEditingController();

  late QuerySnapshot searchSnapshot;

  Widget searchList({required String userName, required String userEmail}) {

    return searchSnapshot != null && searchSnapshot.docs.isNotEmpty
        ? ListView.builder(
      itemCount: searchSnapshot.docs.length,
      itemBuilder: (context, index) {
        final documentData =
        searchSnapshot.docs[index].data() as Map<String, dynamic>;
        final userName = documentData['name'];
        final userEmail = documentData['email'];
        return SearchTile(
          userName: userName,
          userEmail: userEmail,
        );
      },
    )
        : Container(
      // Placeholder widget when searchSnapshot is null or empty
      child: Text('No results found.'),
    );
  }

  initSearch() {
    databaseMethods.getUserByUsername(searchTextEditingController.text).then((val){
      setState(() {
        searchSnapshot=val;
      });
    });
    void fetchData() async {
      CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
      searchSnapshot = await usersCollection.get() as QuerySnapshot<Map<String, dynamic>>;
    }
  }
  chatRoomAndChat({

    required String userName ,

  })
  {
    String chatRoomId=
    getChatRoomId(userName, Constants.myName);
    List <String> users=[userName,Constants.myName];
    Map<String,dynamic> chatRoomMap={
      'users':users,
      'chatroomId':chatRoomId
    };
    DatabaseMethods().chatRoomAndChat(
        chatRoomId,chatRoomMap
    );
    Navigator.pushNamed(context,ConvoScreen.id);
  }

  Widget SearchTile({required String userName,required String userEmail}){
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 24,vertical: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName,style: simpleTextStyle(),),
              Text(userEmail,style: simpleTextStyle(),)
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              chatRoomAndChat(userName: userName,);
              },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30),
              ),
            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
            child: Text('Message',style: simpleTextStyle(),),),
          )
        ],
      ),
    );
  }
   @override
  void initState(){
    super.initState();
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
           Container(
             color: Color(0x54FFFFFF),
             padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
             child: Row(children: [
               Expanded(
                 child:  TextField(
                   controller: searchTextEditingController,
             style: TextStyle(
               color: Colors.white
             ),
          decoration: InputDecoration(
            hintText: 'search username',
                hintStyle:TextStyle(
                  color: Colors.white54,
                  fontSize: 20
                ),
            border: InputBorder.none
          )
      ),
               ),
               GestureDetector(
                 onTap: (){
initSearch;
                 },
                 child: Container(
                     height: 60,
                     width: 60,
                     decoration: BoxDecoration(
                       gradient: LinearGradient(
                         colors: [
                           Color(0x36FFFFFF),
                           Color(0x0FFFFFFF),
                         ]
                       ),
                       borderRadius: BorderRadius.circular(50)
                     ),
                     padding: EdgeInsets.all(12),
                     child: Icon(Icons.search,color: Colors.white,size: 40,)),
               )
             ],),
           ),

            searchList(userName: '', userEmail: ''),
          ],
        ),
      ),
    );
  }
}


getChatRoomId(String a, String b){
  if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
    return'$b\_$a';
  }
  else{
    return '$a\_$b';
  }
}
