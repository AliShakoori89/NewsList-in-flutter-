import 'package:flutter/material.dart';
import 'package:news_with_bloc/blocs/news_detail_bloc.dart';
import 'package:news_with_bloc/models/news_response.dart';
import 'package:news_with_bloc/networking/api_response.dart';
import 'package:news_with_bloc/view/categories_detail.dart';


class PostList extends StatefulWidget {
  var id;
  List cat;
  PostList(this.id,this.cat);
  @override
  _PostListState createState() => _PostListState(id,cat);
}

class _PostListState extends State<PostList> {
  var id;
  List cat;
  NewsDetailBloc _detail_bloc;

  _PostListState(id, mycat){
    this.id=id;
    this.cat = mycat;
    _detail_bloc = NewsDetailBloc(id);
    print("bloc created again");
    // _bloc.fetchNewsDetail(id);
  }

  Color getMycolor(var index){
    if(index%2==0) return Colors.purpleAccent.withOpacity(0.8);
    else return Colors.orange;
  }
  @override
  void dispose() {
    _detail_bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: new AppBar(
          title: Text('News App'),
          centerTitle: true,
        ),
        body: Container(
            child: Column(
              children: <Widget>[
                Text(("hi world")),
                Container(
                  height: 30.0,
                  margin: const EdgeInsets.only(top: 10.0 , bottom: 5.0),
                  child: ListView.builder(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: this.cat.length,
                    itemBuilder: (context,index){
                      return(Container(
                            decoration: ShapeDecoration(
                                color: getMycolor(index),
                                shape:RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)
                                )
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            padding: const EdgeInsets.symmetric(vertical: 2.0 , horizontal: 8.0),
                            child: Text(cat[index].title,
                              style: TextStyle(fontSize: 16.0 , color: Colors.white),
                            ),
                          )
                      );
                    },
                  ),
                ),
                Flexible(
                    child: ListView.builder(
                      itemCount:1,
                      itemBuilder: (context,index){
                        return (
                            new GestureDetector(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 7.0 , vertical: 4.0),
                                child: RefreshIndicator(
                                    // onRefresh: ()=> _detail_bloc.fetchNewsDetail(id),
                                    onRefresh: (){},
                                    child: StreamBuilder<ApiResponse<List<NewsDetailsModel>>>(
                                      stream: _detail_bloc.newsDetailStream,
                                      builder: (context, snapshot){
                                        print("snaaaaaaaapshot"+snapshot.hasData.toString());
                                        if(snapshot.hasData){
                                          print("hi babe"+snapshot.data.data.toString());
                                        }
                                        return Container();
                                      },
                                    )
                                )
                                // Card(
                                //   elevation: 3.0,
                                //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.end,
                                //     children: <Widget>[
                                //       new Flexible(
                                //           flex:2,
                                //           child: Container(
                                //             padding: const EdgeInsets.only(left: 5.0),
                                //             child: Column(
                                //               crossAxisAlignment: CrossAxisAlignment.start,
                                //               children: <Widget>[
                                //                 Text(posts[index].title , style: TextStyle(fontSize: 16.0 , color: Colors.black),textAlign: TextAlign.right,),
                                //                 SizedBox(height: 5.0,),
                                //                 Text(posts[index].date , style: TextStyle(fontSize: 13.0 , color: Colors.grey),textAlign: TextAlign.left,)
                                //               ],
                                //             ),
                                //           )
                                //       ),
                                //       SizedBox(width: 5.0,),
                                //       new Expanded(
                                //           child:Image.network(posts[index].image , width: 65.0 , fit: BoxFit.cover,)
                                //       )
                                //     ],
                                //   ),
                                // ),
                              ),
                              onTap: (){
                                // Navigator.push(context, MaterialPageRoute(builder: (context)=>new NewsDetailsState(this.cat[index],this.cat[index].id)));
                              },
                            )
                        );
                      },
                    )
                )
              ],
            )
        ),
      ),
    );
  }
}
