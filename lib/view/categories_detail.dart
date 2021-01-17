// import 'package:flutter/material.dart';
// import 'package:news_with_bloc/blocs/news_detail_bloc.dart';
// import 'package:news_with_bloc/db_helper/db_helper.dart';
// import 'package:news_with_bloc/models/news_response.dart';
// import 'package:news_with_bloc/networking/api_response.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import 'package:news_with_bloc/repository/news_detail_repository.dart';
//
//
//
// class NewsDetailsState extends StatefulWidget {
//   NewsDetailsModel post;
//   String id;
//
//   NewsDetailsState(this.post, this.id);
//
//   @override
//   _NewsDetailsState createState() =>new _NewsDetailsState(post,id);
// }
//
// class _NewsDetailsState extends State<NewsDetailsState> {
//
//   NewsDetailBloc _newsDetailBloc;
//   NewsDetailsModel post;
//
//   _NewsDetailsState( this.post, String id );
//
//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       onRefresh: () =>
//           _newsDetailBloc.fetchNewsDetail(widget.id),
//       child: StreamBuilder<ApiResponse<List<NewsDetailsModel>>>(
//         stream: _newsDetailBloc.newsDetailStream,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             switch (snapshot.data.status) {
//               case Status.LOADING:
//                 return Loading(loadingMessage: snapshot.data.message);
//                 break;
//               case Status.COMPLETED:
//                 return PostWidget(displayNews: snapshot.data.data);
//                 break;
//               case Status.ERROR:
//                 return Error(
//                   errorMessage: snapshot.data.message,
//                   onRetryPressed: () =>
//                       _newsDetailBloc.fetchNewsDetail(widget.id),
//                 );
//                 break;
//             }
//           }
//           return Container();
//         },
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _newsDetailBloc.dispose();
//     super.dispose();
//   }
// }
//
//
// class PostWidget extends StatefulWidget {
//
//   final List<NewsDetailsModel> displayNews;
//
//   PostWidget({Key key, this.displayNews}) : super(key: key);
//
//   @override
//   _PostWidgetState createState() => _PostWidgetState(displayNews);
// }
//
// class _PostWidgetState extends State<PostWidget> {
//
//   List<NewsDetailsModel> displayNews;
//
//   _PostWidgetState(this.displayNews);
//   var currentindex=0;
//
//   @override
//   Widget build(BuildContext context) {
//
//     List<Widget> tabs =[
//       ShowNewsDetail(displayNews),
//       Comment(displayNews[1].cat)
//     ];
//
//     void onTapped(var index){
//       setState(() {
//         currentindex=index;
//       });
//     }
//
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//           bottomNavigationBar: BottomNavigationBar(
//             currentIndex: currentindex,
//             items: [
//               // ignore: deprecated_member_use
//               BottomNavigationBarItem(icon: Icon(Icons.text_fields),title: Text('ست')),
//               // ignore: deprecated_member_use
//               BottomNavigationBarItem(icon: Icon(Icons.comment),title: Text('کامنت'))
//
//             ],
//             onTap: onTapped,
//           ),
//           body: SafeArea(child: tabs[currentindex])
//       ),
//     );
//   }
// }
//
// class Loading extends StatelessWidget {
//   final String loadingMessage;
//
//   const Loading({Key key, this.loadingMessage}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             loadingMessage,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               //              color: Colors.lightGreen,
//               fontSize: 24,
//             ),
//           ),
//           SizedBox(height: 24),
//           CircularProgressIndicator(
//             valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class Error extends StatelessWidget {
//   final String errorMessage;
//
//   final Function onRetryPressed;
//
//   const Error({Key key, this.errorMessage, this.onRetryPressed})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             errorMessage,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.red,
//               fontSize: 18,
//             ),
//           ),
//           SizedBox(height: 8),
//           RaisedButton(
//             color: Colors.redAccent,
//             child: Text(
//               'Retry',
//               style: TextStyle(
// //                color: Colors.white,
//               ),
//             ),
//             onPressed: onRetryPressed,
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class ShowNewsDetail extends StatefulWidget {
//
//   List<NewsDetailsModel> post;
//
//   ShowNewsDetail( this.post );
//
//   @override
//   _ShowNewsDetailState createState() => _ShowNewsDetailState(post);
// }
//
// class _ShowNewsDetailState extends State<ShowNewsDetail> {
//
//   var isLiked = false;
//   DB_Helper db_helper = new DB_Helper();
//   NewsDetailsModel post;
//
//   _init() async{
//     var temp = await db_helper.CheckData(post.id);
//     setState(() {
//       isLiked = temp;
//     });
//   }
//   _ShowNewsDetailState(var post){
//     this.post=post;
//     _init();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: ListView(
//           children: <Widget>[
//             Column(
//               children: <Widget>[
//                 Stack(
//                   alignment: Alignment.center,
//                   children: <Widget>[
//                     Image.network(post.image, height: 160.0, width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
//                     Container(
//                       height: 160.0,
//                       width: MediaQuery.of(context).size.width,
//                       color: Color(0xFF8C000000),
//                     ),
//                     Text(post.title,style: TextStyle(fontSize: 18.0 , fontWeight: FontWeight.bold , color: Colors.white),textAlign: TextAlign.center,)
//                   ],
//                 ),
//                 SizedBox(height: 10.0,),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Row(
//                       children: <Widget>[
//                         SizedBox(width: 10.0,),
//                         Icon(Icons.date_range),
//                         SizedBox(width: 3.0,),
//                         Text(post.date)
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: <Widget>[
//                         Padding(padding: const EdgeInsets.only(right: 15.0),
//                           child: IconButton(
//                               icon: ChooseIcon(),
//                               onPressed: (){
//                                 _IconClick();
//                               }),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//                 SizedBox(height: 13.0,),
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                   child: Text(post.fullPost, textDirection: TextDirection.rtl, style: TextStyle(fontSize: 17.0)),
//                 )
//               ],
//             )
//           ],
//         )
//     );
//   }
//
//   _IconClick() async{
// //    int res = await db_helper.savePost(post);
// //    print('res=$res');
//     if(isLiked){
//       var del = await db_helper.DeletePost(post.id);
//       print('delete: $del');
//     }else{
//       int res = await db_helper.savePost(post);
//       print('res: $res');
//     }
//     setState(() {
//       if(isLiked){
//         isLiked=false;
//       }else{
//         isLiked=true;
//       }
//     });
//   }
//
//   Icon ChooseIcon(){
//     if(isLiked){
//       return Icon(Icons.favorite , color: Colors.red,);
//     }else{
//       return Icon(Icons.favorite_border);
//     }
//   }
// }
//
// class Comment extends StatefulWidget {
//   var id;
//
//   Comment( this.id );
//
//   @override
//   _CommentState createState() => _CommentState(id);
// }
//
// class _CommentState extends State<Comment> {
//   var id;
//   List commentList = new List(
//   );
//
//   _CommentState(var id) {
//     this.id = id;
//     _LoadData (
//     );
//   }
//
//   _LoadData() async {
//     List li = await getComment (
//         id);
//     setState (
//             () {
//           commentList = li;
//         });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     TextStyle style = new TextStyle(
//         fontSize: 16.0,color: Colors.black);
//     TextStyle date_style = new TextStyle(
//         fontSize: 14.0,color: Colors.black54);
//     return Scaffold (
//       appBar: AppBar (
//         actions: <Widget>[
//           IconButton (
//               icon: Icon (
//                 Icons.send,color: Colors.white,),
//               onPressed: () {
//                 _createDialog (
//                     context);
//               })
//         ],
//       ),
//       body: Container (
//           child: ListView.builder (
//             itemCount: commentList.length,
//             itemBuilder: (context,index) {
//               return (
//                   Container (
//                     color: Colors.white,
//                     margin: const EdgeInsets.only(
//                         top: 6.0),
//                     padding: const EdgeInsets.only(
//                         top: 8.0,right: 4.0),
//                     child: Column (
//                       children: <Widget>[
//                         Row (
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Row (
//                               children: <Widget>[
//                                 SizedBox (
//                                   width: 4.0,),
//                                 Icon (
//                                   Icons.date_range,size: 20.0,
//                                   color: Colors.black54,),
//                                 SizedBox (
//                                   width: 2.0,),
//                                 Text (
//                                   commentList[index]['Date'],style: date_style,)
//                               ],
//                             ),
//                             Row (
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: <Widget>[
//                                 Text (
//                                   commentList[index]['Name'],style: style,),
//                                 SizedBox (
//                                   width: 4.0,),
//                                 Image.asset (
//                                   'img/user.png',height: 45.0,width: 45.0,),
//                               ],
//                             )
//                           ],
//                         ),
//                         Container (
//                           padding: const EdgeInsets.symmetric(
//                               vertical: 7.0,horizontal: 4.0),
//                           width: MediaQuery
//                               .of (
//                               context)
//                               .size
//                               .width,
//                           child: Text (
//                             commentList[index]['Message'],
//                             textAlign: TextAlign.right,style: style,),
//                         )
//                       ],
//                     ),
//                   )
//               );
//             },
//           )
//       ),
//     );
//   }
//
//   _createDialog(BuildContext con) {
//     TextEditingController name_controll = new TextEditingController(
//     );
//     TextEditingController msg_controll = new TextEditingController(
//     );
//
//     Dialog mydialog = new Dialog(
//       shape: RoundedRectangleBorder (
//           borderRadius: BorderRadius.circular (
//               15.0)),
//       child: Container (
//           height: 280.0,
//           padding: const EdgeInsets.all(
//               12.0),
//           child: Column (
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Padding (
//                 padding: const EdgeInsets.only(
//                     top: 6.0),
//                 child: TextField (
//                   controller: name_controll,
//                   textAlign: TextAlign.right,
//                   decoration: InputDecoration (
//                       suffixIcon: Icon (
//                           Icons.person),
//                       hintText: 'نام'
//                   ),
//                 ),
//               ),
//               Padding (
//                 padding: const EdgeInsets.only(
//                     top: 11.0),
//                 child: TextField (
//                   controller: msg_controll,
//                   textAlign: TextAlign.right,
//                   decoration: InputDecoration (
//                       suffixIcon: Icon (
//                           Icons.message),
//                       hintText: 'نظر'
//                   ),
//                 ),
//               ),
//               Padding (
//                   padding: const EdgeInsets.only(
//                       top: 19.0),
//                   child: FlatButton (
//                       onPressed: () {
//                         SendComment (
//                             id,name_controll.text,msg_controll.text);
//                         Navigator.of (
//                             con,rootNavigator: true).pop (
//                         );
//                       },
//                       child: Text (
//                         'ارسال نظر',style: TextStyle (
//                           fontWeight: FontWeight.w800,
//                           color: Colors.purple,
//                           fontSize: 17.0),))
//               )
//             ],
//           )
//       ),
//     );
//     showDialog (
//         context: con,builder: (BuildContext context) => mydialog);
//   }
//
//   Future<dynamic> SendComment(var postid,var name,var msg) async {
//     var url = 'http://app.flutter-learn.ir/s2/api/sendcm.php';
//     var response = await http.post (
//         url,body: {'name': '$name','postid': '$postid','message': '$msg'});
//     print (
//         'Server responses: ${response.body}');
//     return response;
//   }
//
//
//   Future<List> getComment(var ID) async {
//     var url = 'http://app.flutter-learn.ir/s2/api/comment.php?id=' + ID;
//     http.Response response = await http.get (
//         url);
//     return json.decode (
//         response.body);
//   }
// }