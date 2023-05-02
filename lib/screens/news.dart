import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/api/news_api.dart';

class News extends StatefulWidget {
  const News({super.key});

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {

  List allNews = [];
  String textValue = "";
  @override

  void initState() {
    super.initState(); //runs all variable and function created, on the screen
    newsApiCall();
  }

  void newsApiCall() async{
    //getting response from api
    var res = await NewsApi().getAllNews();
    // if res is not null
    if(res != null) {
      print(res.articles);
      setState(() {
        allNews = res.articles;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat("kk:mm:ss \n EEE d MMM ").format(now);

    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child:allNews.isNotEmpty? ListView.builder( //when we need to put widget on a loop
            physics: const NeverScrollableScrollPhysics(), //turns off scroll property of list builder
            shrinkWrap: true, //It reduces the list builder's height to the height of the containers
            itemCount: allNews.length, //value 11807
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(allNews[index].urlToImage != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        allNews[index].urlToImage,
                        width: 150,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            allNews[index].title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          if(allNews[index].author != null)
                          Text(
                            allNews[index].author,
                            style: TextStyle(
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          Text(
                            allNews[index].publishedAt.toString(),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text("Published By: prajitaadhikari.com.np"),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          ):Container(),
        ),
      ),
    );
  }
}
