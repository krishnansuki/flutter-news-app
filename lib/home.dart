import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import './countries.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _defaultCountryCode = 'in';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Room'),
        backgroundColor: Colors.black,
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              var countrycode = await Navigator.of(context).pushNamed(
                Countries.router,
              );
              if (countrycode.toString().isNotEmpty) {
                setState(() {
                  _defaultCountryCode = countrycode;
                });
              }
            },
            child: Text(
              'Country',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: http.get(
            'http://newsapi.org/v2/top-headlines?country=$_defaultCountryCode&category=business&apiKey=468e945931fd446dbc9ad0d2e010af7c'),
        builder: (context, newsData) => newsData.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: json.decode(newsData.data.body)['articles'].length,
                itemBuilder: (context, index) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        Image.network(
                            json.decode(newsData.data.body)['articles'][index]
                                    ['urlToImage'] ??
                                "https://1m19tt3pztls474q6z46fnk9-wpengine.netdna-ssl.com/wp-content/themes/unbound/images/No-Image-Found-400x264.png",
                            loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return Container(
                            height: 200,
                            width: double.infinity,
                            child: Center(
                                child: CircularProgressIndicator(
                              value: progress.expectedTotalBytes != null
                                  ? progress.cumulativeBytesLoaded /
                                      progress.expectedTotalBytes
                                  : null,
                            )),
                          );
                        }),
                        SizedBox(
                          height: 15,
                        ),
                        Text(json.decode(newsData.data.body)['articles'][index]
                            ['title']),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
