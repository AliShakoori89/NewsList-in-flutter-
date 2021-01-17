import 'package:flutter/material.dart';
import 'package:news_with_bloc/blocs/news_bloc.dart';
import 'package:news_with_bloc/models/news_response.dart';
import 'package:news_with_bloc/networking/api_response.dart';
import 'package:news_with_bloc/view/categories_post.dart';

import 'categories_detail.dart';



class NewsScreen extends StatefulWidget {
  final Color iconColor;
  final List<Color> actionContainerColor;

  const NewsScreen({Key key, this.iconColor, this.actionContainerColor}) : super(key: key);
  @override
  _NewsScreenState createState() => _NewsScreenState(iconColor,actionContainerColor);
}

class _NewsScreenState extends State<NewsScreen> {
  CategoryBloc _bloc;
  List<Color> _backgroundColor;
  Color iconColor;
  Color _textColor;
  List<Color> actionContainerColor;
  Color _borderContainer;
  bool colorSwitched = true;
  var logoImage;

  _NewsScreenState(this.iconColor, this.actionContainerColor);

  @override
  void initState() {
    changeTheme();
    super.initState();
    _bloc = CategoryBloc();
  }

  void changeTheme() async {
    if (colorSwitched) {
      setState(() {
        logoImage = 'assets/images/internet.png';
        _backgroundColor = [
          Color.fromRGBO(252, 214, 0, 1),
          Color.fromRGBO(251, 207, 6, 1),
          Color.fromRGBO(250, 197, 16, 1),
          Color.fromRGBO(249, 161, 28, 1),
        ];
        iconColor = Colors.white;
        _textColor = Color.fromRGBO(253, 211, 4, 1);
        _borderContainer = Color.fromRGBO(34, 58, 90, 0.2);
        actionContainerColor = [
          Color.fromRGBO(47, 75, 110, 1),
          Color.fromRGBO(43, 71, 105, 1),
          Color.fromRGBO(39, 64, 97, 1),
          Color.fromRGBO(34, 58, 90, 1),
        ];
      });
    } else {
      setState(() {
        logoImage = 'assets/images/internet.png';
        _borderContainer = Color.fromRGBO(252, 233, 187, 1);
        _backgroundColor = [
          Color.fromRGBO(47, 75, 110, 1),
          Color.fromRGBO(43, 71, 105, 1),
          Color.fromRGBO(39, 64, 97, 1),
          Color.fromRGBO(34, 58, 90, 1),
        ];
        iconColor = Colors.black;
        _textColor = Colors.black;
        actionContainerColor = [
          Color.fromRGBO(255, 212, 61, 1),
          Color.fromRGBO(255, 212, 55, 1),
          Color.fromRGBO(255, 211, 48, 1),
          Color.fromRGBO(255, 211, 43, 1),
        ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SafeArea(
            child: GestureDetector(
              onLongPress: () {
                if (colorSwitched) {
                  colorSwitched = false;
                } else {
                  colorSwitched = true;
                }
                changeTheme();
              },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        stops: [0.2, 0.3, 0.5, 0.8],
                        colors: _backgroundColor)),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      height: 5.0,
                    ),
                    Image.asset(
                      logoImage,
                      fit: BoxFit.contain,
                      height: 100.0,
                      width: 100.0,
                    ),
                    Text(
                      'اخبار',
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 300.0,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: _borderContainer,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15)),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  stops: [0.2, 0.4, 0.6, 0.8],
                                  colors: actionContainerColor)),
                          child:RefreshIndicator(
                              onRefresh: ()=> _bloc.fetchCategory(),
                              child: StreamBuilder<ApiResponse<List<CategoryModel>>>(
                                stream: _bloc.categoriesListStream,
                                builder: (context, snapshot){
                                  if(snapshot.hasData){
                                    switch (snapshot.data.status){
                                      case Status.LOADING:
                                        return Loading(loadingMessage: snapshot.data.message);
                                        break;
                                      case Status.COMPLETED:
                                        return NewsListDetails(mycat: snapshot.data.data);
                                        break;
                                      case Status.ERROR:
                                        return Error(
                                          errorMessage: snapshot.data.message,
                                          onRetryPressed: () => _bloc.fetchCategory(),
                                        );
                                        break;
                                    }
                                  }
                                  return Container();
                                },
                              )
                          )
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}

class NewsListDetails extends StatelessWidget {
  final List<CategoryModel> mycat;

  NewsListDetails({Key key, this.mycat}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: mycat.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
              childAspectRatio: 1.5
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Container(
                child: InkWell(
                  onTap: () {
                    print(mycat[index].id);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PostList(mycat[index].id,mycat)));
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 30.0,),
                      Image.network(mycat[index].icon , height: 45.0 , width: 45.0,),
                      Text(mycat[index].title , style: TextStyle(fontSize: 18.0 ,color: Colors.deepOrange),),
                      Divider(
                        color: Colors.grey,
                        height: 5.0,
                      ),
                    ],
                  ),
                )
              ),
            );
          }
      )
    );
  }
}


class Error extends StatelessWidget {
  final String errorMessage;

  final Function onRetryPressed;

  const Error({Key key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.redAccent,
            child: Text(
              'Retry',
              style: TextStyle(
                //                color: Colors.white,
              ),
            ),
            onPressed: onRetryPressed,
          )
        ],
      ),
    );
  }
}

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            loadingMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              //              color: Colors.lightGreen,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 24),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
          ),
        ],
      ),
    );
  }
}