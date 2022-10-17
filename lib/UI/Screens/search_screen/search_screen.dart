import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:massa_app/Api/ApiSettings.dart';
import 'package:massa_app/Api/model/search_model.dart';
import 'package:massa_app/Api/model/sort_folder_model.dart';
import 'package:massa_app/Api/search_api_controller/search_api_controller.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:massa_app/Api/model/folders_model.dart';
import 'package:massa_app/UI/Screens/BotoomNaviagtion/HomeScreen.dart';
import 'package:massa_app/UI/Screens/image_details.dart';

import '../../../Api/ApiSettings.dart';
import '../../../Api/model/sort_folder_model.dart';
import '../../../Storage/shared_pref_controller.dart';
import '../video_details.dart';
import '../image_details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _controller = TextEditingController();

  String comment = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _controller.text = '';
                    comment = '';
                  });
                },
                icon: Icon(Icons.close))
          ],
          backgroundColor: Color(0xff6F15DE),
          title: TextField(
            onChanged: (value) {
              setState(() {
                comment = _controller.text;
              });
            },
            style: TextStyle(color: Colors.white),
            controller: _controller,
            cursorColor: Color(0xffFFB300),
            decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.search,
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  'Comments Result',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                child: FutureBuilder<List<SearchModel>>(
                    future:
                        SearchApiController().getSearchResult(comment: comment),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Color(0xff6F15DE),
                          ),
                        );
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ImageDetails(
                                          time: snapshot.data![index].createdAt,
                                          date: snapshot.data![index].createdAt,
                                          url: snapshot.data![index].name,
                                          comment:
                                              snapshot.data![index].comment,
                                          lat: snapshot.data![index].lat,
                                          long: snapshot.data![index].long,
                                        ),
                                        //     Category(
                                        //   time: element.createdAt,
                                        //   date: element.createdAt,
                                        //   url: element.image,
                                        //   comment: element.comment,
                                        //   lat: element.lat,
                                        //   long: element.long,
                                        // ),
                                      ),
                                    );
                                  },
                                  leading: CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.grey,
                                      backgroundImage: NetworkImage(
                                          '${ApiSettings.baseUrl}${snapshot.data![index].name}')),
                                  title: Text(snapshot.data![index].comment),
                                ),
                              );
                            });
                      } else {
                        return Center(
                          child: Text('no data'),
                        );
                      }
                    }),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  'Folders Result',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: FutureBuilder<List<Data>>(
                    future: getFolders(value: comment),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: Color(0xff6F15DE),
                        ));
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
                        return GridView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.w.h,
                              mainAxisSpacing: 10.w,
                            ),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (builder) {
                                    return HomeScreen(
                                        id: snapshot.data![index].id
                                            .toString());
                                  }));
                                },
                                child: Container(
                                  width: 80.w,
                                  height: 70.h,
                                  child: Column(
                                    children: [
                                      Image.asset('images/Image_Sorage.png'),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Text(
                                        snapshot.data![index].name.toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Center(
                          child: Text('there is no folders yet'),
                        );
                      }
                    })),
          ],
        ));
  }

  Future<List<Data>> getFolders({required String value}) async {
    var response = await http.get(
        Uri.parse('http://176.126.87.26/api/main-folders?key=$value'),
        headers: {
          'Authorization': 'Bearer ${SharedPrefController().token}',
        });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = await jsonDecode(response.body)['data'] as List;
      return data.map((e) => Data.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
