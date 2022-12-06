import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/widgets.dart';
bool lastDicission_IN =false;
bool lastDicission_OUT =false;

Future<void> main() async {
  await Firebase.initializeApp(options: FirebaseOptions( apiKey: "AIzaSyCOlOt_wASB3MFhgShbgUmBdSqXwDzxYEo",
      authDomain: "staht-todo.firebaseapp.com",
      projectId: "staht-todo",
      storageBucket: "staht-todo.appspot.com",
      messagingSenderId: "333347798300",
      appId: "1:333347798300:web:7d70a897f1ddec46258ed9",
      measurementId: "G-49SXL3LNQJ"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      initialRoute:FirebaseAuth.instance.currentUser==null? Login.route: HomePage.route,
      routes: {
        Login.route: (context) => Login(),
        HomePage.route: (context) => HomePage(),
      },onUnknownRoute: (RouteSettings settings) {
      return MaterialPageRoute<void>(
        settings: settings,
        builder: (BuildContext context) =>
            UnknownArticle(),
      );
    },
     // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


class Login extends StatefulWidget {
  static const String route = '/';
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController(text: "md.aminul.islam@staht.com");
  TextEditingController pass = TextEditingController(text: "123456");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FirebaseAuth.instance.createUserWithEmailAndPassword(email: "md.aminul.islam@staht.com", password: "123456").then((value) {
    //   value.user!.updateDisplayName("Mukul");
    //
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Card(child: Container(width: 500,child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Wrap(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(left: 5),
          //   child: Text("Email"),
          // ),
          Container(margin: EdgeInsets.all(8),child: TextFormField(controller: email,textAlignVertical: TextAlignVertical.center,textAlign :TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
            decoration: InputDecoration(hintText: "Email addes",
                enabledBorder:enabled,disabledBorder: disabled,focusedBorder: focused
            ),),),
          // Padding(
          //   padding: const EdgeInsets.only(left: 5),
          //   child: Text("Password"),
          // ),
          Container(margin: EdgeInsets.all(8),child: TextFormField(controller: pass,textAlignVertical: TextAlignVertical.center,textAlign :TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold),
            decoration: InputDecoration(hintText: "Password",
                enabledBorder:enabled,disabledBorder: disabled,focusedBorder: focused
            ),),),
          Container(margin: EdgeInsets.only(left: 4,right: 4,top: 8,bottom: 8),child: InkWell(onTap: () async {
            //MyHomePage


            try{
             UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: pass.text);
             if(user.user ==null){

             }else{
               Navigator.pushReplacementNamed(context, HomePage.route);
             }
            }catch(e){

            }


          },child: Card(color: Theme.of(context).primaryColor,child: Container(height: 45,width: 500,child: Center(child: Text("Login",style: TextStyle(color: Colors.white),),)),)),),

        ],
      ),
    ),),),),);
  }
}

class UnknownArticle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unknown article'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Unknown article'),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  static const String route = '/home';
  const HomePage({Key? key}) : super(key: key);



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int type = 0 ;
  @override
  void initState() {
    // TODO: implement initState


    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((event) {
      if(event==null && (lastDicission_IN == true) && (lastDicission_OUT = false)){
        lastDicission_IN = false ;
        lastDicission_OUT = true ;
        Navigator.pushReplacementNamed(context, Login.route);
      }else if((lastDicission_IN == false) && (lastDicission_OUT = true)){
        lastDicission_IN = true ;
        lastDicission_OUT = false ;
        Navigator.pushReplacementNamed(context, HomePage.route);
      }
    });

  }


  Widget buildSegment(String text){
    return Container(
      child: Text(text,style: TextStyle(fontSize: 22,
          color: Colors.black),),
    );
  }
  @override
  Widget build(BuildContext context) {


    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(""),leading: Container(width: 0,height: 0,),
        ),floatingActionButton: FloatingActionButton.extended(onPressed: (){
      TextEditingController title = TextEditingController(text: "");
      TextEditingController description = TextEditingController(text: "");

      int tag = 0 ;
      String tag__T = "Priority" ;
      int status = 0 ;
      String status__T = "Pending" ;

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Container(width: 600,child: Wrap(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 5),
                  //   child: Text("Email"),
                  // ),
                  Container(margin: EdgeInsets.all(8),child: TextFormField(controller: title,textAlignVertical: TextAlignVertical.center,textAlign :TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(hintText: "Title",
                        enabledBorder:enabled,disabledBorder: disabled,focusedBorder: focused
                    ),),),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 5),
                  //   child: Text("Password"),
                  // ),
                  Container(margin: EdgeInsets.all(8),child: TextFormField(minLines: 2,maxLines: 3,controller: description,textAlignVertical: TextAlignVertical.center,textAlign :TextAlign.start,style: TextStyle(fontWeight: FontWeight.bold),
                    decoration: InputDecoration(hintText: "Description",
                        enabledBorder:enabled,disabledBorder: disabled,focusedBorder: focused
                    ),),),
                  RadioForTag(onChangedT: (String tagT){
                    tag__T = tagT;
                  },onChanged: (int val ) {
                    tag = val;

                  },),
                  RadioForStatus(onChangedT: (String val){
                    status__T = val ;
                  },onChanged: (int val ) {
                    status = val;

                  },),
                  Container(margin: EdgeInsets.only(left: 4,right: 4,top: 8,bottom: 8),child: InkWell(onTap: () async {
                    //MyHomePage


                    try{
                      FirebaseFirestore.instance.collection("tasks").add({"time":DateTime.now().millisecondsSinceEpoch,"tag":tag,"tag_T":tag__T,"status":status,"status_T":status__T,"title":title.text,"description":description.text,"email":FirebaseAuth.instance.currentUser!.email,"uid":FirebaseAuth.instance.currentUser!.uid,"name":FirebaseAuth.instance.currentUser!.displayName});

                      Navigator.of(context).pop();
                    }catch(e){

                    }


                  },child: Card(color: Theme.of(context).primaryColor,child: Container(height: 45,width: 500,child: Center(child: Text("Add",style: TextStyle(color: Colors.white),),)),)),),

                ],
              ),),
            );});

    }, label: Text("Add Task")),
       body: StreamBuilder<QuerySnapshot>(
           stream: FirebaseFirestore.instance.collection("tasks").orderBy("time",descending: true).snapshots(),
           builder: (c, snapshot) {
             if(snapshot.hasData){
               return ListView.builder(
                 itemCount: snapshot.data!.docs.length,

                 itemBuilder: (context, index) {
                   return InkWell(onTap: (){
                     TextEditingController controller  = TextEditingController();

                      showDialog(
                      context: context,
                      builder: (context)
                            {
                            return AlertDialog(content: Container(width: 850,
                              child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(width: 450,
                                    child: Wrap(
                                      children: [
                                        TextFormField(onChanged: (String t){
                                          snapshot.data!.docs[index].reference.update({"title":t});
                                        },initialValue: snapshot.data!.docs[index].get("title"),textAlign :TextAlign.start,
                                          style: TextStyle(fontWeight: FontWeight.normal),
                                          decoration: InputDecoration(hintText: "Title",labelText: "Title",
                                              enabledBorder:enabled,disabledBorder: disabled,focusedBorder: focused
                                          ),),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 15),
                                          child: TextFormField(onChanged: (String t){
                                            snapshot.data!.docs[index].reference.update({"description":t});
                                          },maxLines: 4,minLines: 3,initialValue: snapshot.data!.docs[index].get("description"),textAlign :TextAlign.start,
                                            style: TextStyle(fontWeight: FontWeight.normal),
                                            decoration: InputDecoration(hintText: "Description",labelText: "Description",
                                                enabledBorder:enabled,disabledBorder: disabled,focusedBorder: focused
                                            ),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 15),
                                          child: TextFormField(controller: controller,maxLines: 2,minLines: 1,textAlign :TextAlign.start,
                                            style: TextStyle(fontWeight: FontWeight.normal),
                                            decoration: InputDecoration(hintText: "Add Comment",labelText: "Add Comment",
                                                enabledBorder:enabled,disabledBorder: disabled,focusedBorder: focused
                                            ),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 15),
                                          child: Card(color: Colors.blue,child: InkWell(onTap: (){
                                            snapshot.data!.docs[index].reference.collection("comments").add({"time":DateTime.now().millisecondsSinceEpoch,"text":controller.text});
                                          },child: Center(child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text("Add Comment"),
                                          ),),),),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 05),
                                          child: Card(color: Colors.grey,child: InkWell(onTap: (){
                                            Navigator.pop(context);

                                          },child: Center(child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text("Close"),
                                          ),),),),
                                        ),


                                      ],
                                    ),
                                  ),
                                  Container(width: 400,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: StreamBuilder<QuerySnapshot>(
                                          stream: snapshot.data!.docs[index].reference.collection("comments").orderBy("time",descending: true).snapshots(),
                                          builder: (c, snapshot) {
                                            if(snapshot.hasData){
                                              return ListView.separated(shrinkWrap: true,
                                                  itemCount: snapshot.data!.docs.length,

                                                  itemBuilder: (context, index) {
                                                    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(snapshot.data!.docs[index].get("text")),
                                                        Row(
                                                          children: [
                                                            Text(DateFormat('hh mm a dd MMM').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data!.docs[index].get("time"))),style: TextStyle(fontSize: 12),),
                                                            InkWell(child: Icon(Icons.delete),onTap: (){
                                                              snapshot.data!.docs[index].reference.delete();
                                                            },),
                                                          ],
                                                        ),


                                                      ],
                                                    );
                                                  }, separatorBuilder: (BuildContext context, int index) { return Divider(); },);


                                            }else{
                                              return Container(height: 0,width: 0,);

                                            }}),
                                    ),
                                  ),
                                ],
                              ),
                            ),);
                            });

                   },
                     child: Container(margin: EdgeInsets.all(10),decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade50),borderRadius: BorderRadius.circular(5)),
                       child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               Padding(
                                 padding: const EdgeInsets.all(8.0),
                                 child: Text(snapshot.data!.docs[index].get("title").toString().toUpperCase()),
                               ),
                               Row(
                                 children: [

                                   IconButton(onPressed: (){
                                     snapshot.data!.docs[index].reference.delete();
                                   }, icon: Icon(Icons.delete)),
                                   Padding(
                                     padding: const EdgeInsets.all(8.0),
                                     child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.white),borderRadius: BorderRadius.circular(3)),child: Padding(
                                       padding: const EdgeInsets.all(4.0),
                                       child: Text(DateFormat('dd MMM hh mm a').format(DateTime.fromMillisecondsSinceEpoch(snapshot.data!.docs[index].get("time"))),

                                         style: TextStyle(color: Colors.white),),
                                     ),),
                                   ),
                                   InkWell(onTap: (){
                                     if(snapshot.data!.docs[index].get("tag")==0){
                                       snapshot.data!.docs[index].reference.update({"tag":1,"tag_T":"Normal"});
                                     }else
                                     if(snapshot.data!.docs[index].get("tag")==1){
                                       snapshot.data!.docs[index].reference.update({"tag":2,"tag_T":"Park"});
                                     }else
                                     if(snapshot.data!.docs[index].get("tag")==2){
                                       snapshot.data!.docs[index].reference.update({"tag":0,"tag_T":"Priority"});
                                     }
                                   },
                                     child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Container(decoration: BoxDecoration(color:snapshot.data!.docs[index].get("tag")==0?Colors.red:((snapshot.data!.docs[index].get("tag")==1?Colors.blue:Colors.grey)),
                                        borderRadius: BorderRadius.circular(5)),child: Padding(
                                         padding: const EdgeInsets.all(4.0),
                                         child: Text(snapshot.data!.docs[index].get("tag")==0?"Priority":(snapshot.data!.docs[index].get("tag")==1?"Normal":"Park"),
                                           style: TextStyle(color: Colors.white),),
                                       ),),
                                     ),
                                   ),
                                   InkWell(onTap: (){

                                     if(snapshot.data!.docs[index].get("status")==0){
                                       snapshot.data!.docs[index].reference.update({"updated":DateTime.now().millisecondsSinceEpoch,"status":1,"status_T":"On Progress"});
                                     }else
                                     if(snapshot.data!.docs[index].get("status")==1){
                                       snapshot.data!.docs[index].reference.update({"updated":DateTime.now().millisecondsSinceEpoch,"status":2,"status_T":"Done"});
                                     }else
                                     if(snapshot.data!.docs[index].get("status")==2){
                                       snapshot.data!.docs[index].reference.update({"updated":DateTime.now().millisecondsSinceEpoch,"status":0,"status_T":"Pending"});
                                     }


                                   },
                                     child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Container(decoration: BoxDecoration(color:snapshot.data!.docs[index].get("status")==0?Colors.red:
                                       ((snapshot.data!.docs[index].get("status")==1?Colors.blue:Colors.grey)),
                                           borderRadius: BorderRadius.circular(5)),child: Padding(
                                         padding: const EdgeInsets.all(4.0),
                                         child: Text(snapshot.data!.docs[index].get("status_T"),
                                           style: TextStyle(color: Colors.white),),
                                       ),),
                                     ),
                                   ),
                                 ],
                               ),
                             ],
                           ),
                           Padding(
                             padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
                             child: Text(snapshot.data!.docs[index].get("description")),
                           ),

                         ],
                       ),
                     ),
                   );
                 },
               );

             }else{
               return Container(height: 0,width: 0,);
             }
           }),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class RadioForTag extends StatefulWidget {
  Function(int) onChanged  ;
  Function(String) onChangedT  ;

  int? initial;

  RadioForTag({required this.onChangedT,required this.onChanged,this.initial});

  @override
  State<RadioForTag> createState() => _RadioForTagState();
}

class _RadioForTagState extends State<RadioForTag> {

  int selctedPoint = 0 ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.initial == null){

    }else{
      setState(() {
        selctedPoint = widget.initial! ;

      });
    }

  }



  @override
  Widget build(BuildContext context) {
    return  Row(children : [

      Expanded(
        child: CheckboxListTile(title: Text("Priority"),value: selctedPoint==0, onChanged: (bool? val){
          setState(() {
            if(val == true)
              selctedPoint = 0 ;
            widget.onChanged(selctedPoint);
            widget.onChangedT("Priority");
          });
        }),
      ),
      Expanded(child: CheckboxListTile(title: Text("Normal"),value: selctedPoint==1, onChanged: (bool? val){
        setState(() {
          if(val == true)
            selctedPoint = 1 ;
          widget.onChanged(selctedPoint);
          widget.onChangedT("Normal");
        });
      }),),
      Expanded(child:CheckboxListTile(title: Text("Park"),value: selctedPoint==2, onChanged: (bool? val){
        setState(() {
          if(val == true)
            selctedPoint = 2 ;
          widget.onChanged(selctedPoint);
          widget.onChangedT("Park");
        });
      }),),



    ]);
  }
}






class RadioForStatus extends StatefulWidget {
  Function(int) onChanged  ;
  Function(String) onChangedT  ;

  int? initial;

  RadioForStatus({required this.onChanged,required this.onChangedT,this.initial});

  @override
  State<RadioForStatus> createState() => _RadioForStatusState();
}

class _RadioForStatusState extends State<RadioForStatus> {

  int selctedPoint = 0 ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.initial == null){

    }else{
      setState(() {
        selctedPoint = widget.initial! ;

      });
    }

  }



  @override
  Widget build(BuildContext context) {
    return  Row(children : [

      Expanded(
        child: CheckboxListTile(title: Text("Pending"),value: selctedPoint==0, onChanged: (bool? val){
          setState(() {
            if(val == true)
              selctedPoint = 0 ;
            widget.onChanged(selctedPoint);
            widget.onChangedT("Pending");
          });
        }),
      ),
      Expanded(child: CheckboxListTile(title: Text("On Progress"),value: selctedPoint==1, onChanged: (bool? val){
        setState(() {
          if(val == true)
            selctedPoint = 1 ;
          widget.onChanged(selctedPoint);
          widget.onChangedT("On Progress");
        });
      }),),
      Expanded(child:CheckboxListTile(title: Text("Done"),value: selctedPoint==2, onChanged: (bool? val){
        setState(() {
          if(val == true)
            selctedPoint = 2 ;
          widget.onChanged(selctedPoint);
          widget.onChangedT("Done");
        });
      }),),



    ]);
  }
}