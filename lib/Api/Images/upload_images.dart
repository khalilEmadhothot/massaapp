import 'dart:convert';
import 'dart:io';

import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:massa_app/Api/model/api_response.dart';
import 'package:massa_app/UI/Screens/BotoomNaviagtion/BottomNaviagtionScreen.dart';
import 'package:massa_app/get/get_api_controller.dart';
import 'package:massa_app/utils/helpers.dart';
import 'package:video_player/video_player.dart';

import '../../Storage/shared_pref_controller.dart';
import '../../UI/Screens/aspect_ration_video.dart';
import '../../core/constant.dart';
import '../ApiSettings.dart';
import '../model/folders_model.dart';

class UploadImages extends StatefulWidget {
  const UploadImages({Key? key}) : super(key: key);

  @override
  State<UploadImages> createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> with Helpers {
  dynamic selected;
  int selectedFolderId = 0;
  List<Data> folders = [];

  bool played = false;
  var size;
  XFile? _pickedImage;
  XFile? _pickedVideo;
  late ImagePicker _imagePicker;
  dynamic currentTime = DateFormat.jm().format(DateTime.now());
  dynamic currentTime2 = DateFormat.yMd().format(DateTime.now());
  double? _progressValue = 0;
  String lat = "";
  String long = "";
  TextEditingController _commentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  VideoPlayerController? _controller;
  bool isCaptured = false;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   await Geolocator.openAppSettings();
    //   return Future.error('Location services are disabled.');
    // }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
    getFolders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          Padding(
            padding:
                const EdgeInsetsDirectional.only(start: 15, end: 15, top: 20),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      width: 100.w,
                      height: 45.h,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        color: Color(0xff6F15DE),
                        borderRadius: BorderRadius.circular(8).r,
                      ),
                      child: Text(
                        'LOGO',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 19.sp,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, '/BootomNaviagtionScreen');
                    },
                    child: Container(
                        width: 38.w,
                        height: 38.h,
                        alignment: AlignmentDirectional.center,
                        decoration: BoxDecoration(
                          color: Color(0xff6F15DE),
                          borderRadius: BorderRadius.circular(10).r,
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 18.h,
                        )),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          LinearProgressIndicator(
            value: _progressValue,
            minHeight: 5,
            color: const Color(0xff6F15DE),
            backgroundColor: const Color(0xffE4E4E4),
          ),
          Expanded(
            child: _pickedImage == null && _controller == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            await _pickImage();
                          },
                          child: Center(
                            child: Icon(
                              Icons.camera_enhance_outlined,
                              size: 50,
                              // CupertinoIcons.camera
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final XFile? file = await _picker.pickVideo(
                                source: ImageSource.camera,
                                maxDuration: const Duration(seconds: 10));
                            setState(() {
                              _pickedVideo = file;
                              isCaptured = true;
                            });
                            getFileSize(file!, "");
                            _playVideo(file);
                          },
                          child: Center(
                              child: Icon(Icons.video_call_outlined,
                                  // CupertinoIcons.video_camera,
                                  size: 50)),
                        ),
                      ),
                    ],
                  )
                : _pickedImage != null && _controller == null
                    ? ListView(
                        children: [
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(top: 10),
                              child: Container(
                                width: 220,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25).r,
                                  color: Color(0xffFFB300),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          // CupertinoIcons.calendar_today,
                                          Icons.calendar_today_sharp,
                                          color: Colors.white,
                                          size: 17.r,
                                        ),
                                        SizedBox(
                                          width: 3.w,
                                        ),
                                        Text(
                                          "$currentTime2",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.h,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.punch_clock,
                                          // CupertinoIcons.clock,
                                          color: Colors.white,
                                          size: 17.r,
                                        ),
                                        SizedBox(
                                          width: 3.r,
                                        ),
                                        Text(
                                          "$currentTime",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14.h,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              Image.asset(
                                "images/mapss.png",
                                width: 450.w,
                                height: 200.h,
                              ),
                              InkWell(
                                onTap: () async {
                                  Position position =
                                      await _determinePosition();
                                  print(" LAT IS ${position.latitude}");
                                  print(" LAT IS ${position.latitude}");
                                  lat = position.latitude.toString();
                                  long = position.longitude.toString();
                                },
                                child: Center(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 60, horizontal: 100),
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff6F15DE),
                                      borderRadius: BorderRadius.circular(50).r,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        // CupertinoIcons.location,
                                        Icons.location_on_sharp,
                                        color: Colors.white,
                                        size: 25.r,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Text("lat is $lat"),
                          // Text("long is $long"),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: SizedBox(
                              // width: 600,
                              height: 320.h,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25.0).r,
                                child: Image.file(
                                  File(
                                    _pickedImage!.path,
                                  ),
                                  // fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // margin: EdgeInsets.symmetric(horizontal:20),
                            padding: EdgeInsets.all(10),
                            child: DropdownButton(
                              hint: Text('Choose Folder'),
                              underline: Divider(
                                thickness: 0,
                              ),
                              isExpanded: true,
                              onChanged: (value) {
                                value as Data;
                                setState(() {
                                  selected = value;
                                  selectedFolderId = value.id ?? 0;
                                  print(selectedFolderId);
                                });
                              },
                              value: selected,
                              items: folders
                                  .map((e) => DropdownMenuItem(
                                        child: Text("${e.name}"),
                                        value: e,
                                      ))
                                  .toList(),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SingleChildScrollView(
                            child: Container(
                              width: 321.w,
                              height: 45.h,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 35,
                              ),
                              child: TextField(
                                controller: _commentController,
                                //  keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    labelText: AppLocalizations.of(context)!
                                        .writeComment,
                                    suffixIcon: IconButton(
                                      icon: Container(
                                        width: 60.w,
                                        height: 60.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20).r,
                                          color: secondaryColor,
                                        ),
                                        child: Icon(
                                          Icons.send,
                                          // CupertinoIcons.arrow_up_circle,
                                          color: Colors.white,
                                          size: 20.r,
                                        ),
                                      ),
                                      onPressed: () {},
                                    ),
                                    labelStyle: TextStyle(
                                        fontSize: 16.sp,
                                        fontStyle: FontStyle.italic,
                                        color: Color(0xff888888),
                                        fontWeight: FontWeight.w500),
                                    fillColor: Color(0xffFAFAFA),
                                    filled: true,
                                    helperMaxLines: 2,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xffc6cad4), width: 1.w),
                                      borderRadius: BorderRadius.circular(27).r,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0xff50535c), width: 1.w),
                                      borderRadius: BorderRadius.circular(27).r,
                                    ),
                                    constraints: BoxConstraints(
                                      maxHeight: 372.h,
                                      minWidth: 53.w,
                                    )), // decoration: InputDecoration(
                              ),
                            ),
                          ),
                        ],
                      )
                    : _pickedImage == null && _controller != null
                        ? _previewVideo()
                        : Container(),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              uploadImageProgress();
              print("CLICK SIZE: $size");
              if (selectedFolderId == 0) {
                Fluttertoast.showToast(
                    msg: "you must add folder name",
                    // AppLocalizations.of(context)!
                    //     .nameAndNumbermustbenotempty, // message
                    toastLength: Toast.LENGTH_SHORT,
                    // length
                    backgroundColor: Colors.red,
                    gravity: ToastGravity.BOTTOM, // location
                    timeInSecForIosWeb: 3 // duration
                    );
              } else if (lat == "" && long == "") {
                Fluttertoast.showToast(
                    msg: "you must choose the location",
                    // AppLocalizations.of(context)!
                    //     .youmustchoosethelocation, // message
                    toastLength: Toast.LENGTH_SHORT,
                    // length
                    backgroundColor: Colors.red,
                    gravity: ToastGravity.BOTTOM, // location
                    timeInSecForIosWeb: 3 // duration
                    );
              }
              await uploadFile(
                  _pickedImage != null
                      ? _pickedImage!.path
                      : _pickedVideo!.path,
                  //!= null ? _pickedImage!.path : "",
                  _pickedImage != null && _controller == null
                      ? "image"
                      : _pickedImage == null && _controller != null
                          ? "video"
                          : "not determined",
                  size,
                  selectedFolderId,
                  double.parse(lat),
                  double.parse(long),
                  _commentController.text);
            },
            //await _PerformImage(),
            icon: const Icon(
                // CupertinoIcons.cloud_upload,
                Icons.cloud_upload),
            label: Text(
              AppLocalizations.of(context)!.uPLOADIMAGE,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              primary: const Color(0xffFFB300),
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    XFile? image = await _imagePicker.pickImage(
      source: ImageSource.camera,
      // imageQuality: 80,
    );
    if (image != null) {
      setState(() {
        _pickedImage = image;
        getFileSize(image, 'image');
      });
    }
  }

  bool _checkData() {
    if (_pickedImage != null) {
      return true;
    }
    showSnackBar(context, message: 'Pick image to upload!', error: true);
    return false;
  }

  Future<void> _PerformImage() async {
    if (_checkData()) {
      await _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    // _updateProgressValue();
    // ImagesApiController.UploadImage(file: File(_pickedImage!.path));
    print("PATH: ${_pickedImage!.path}");
    await ImagesGetxController.to
        .uploadImage(context, file: File(_pickedImage!.path),
            uploadImageCallback: (ApiResponse apiResponse) {
      _updateProgressValue(value: apiResponse.success ? 1 : 0);

      showSnackBar(context,
          message: apiResponse.description, error: !apiResponse.success);
    });
  }

  Future uploadImageProgress() async {
    setState(() {
      _progressValue = null;
    });
  }

  void _updateProgressValue({double? value}) {
    setState(() => _progressValue = value);
  }

  Widget _previewVideo() {
    if (_controller == null) {
      return const Text(
        'You have not yet picked a video',
        textAlign: TextAlign.center,
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Color(0xffFFB300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      const Icon(
                        // CupertinoIcons.calendar_today,
                        Icons.calendar_today_sharp,
                        color: Colors.white,
                        size: 17,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        "$currentTime2",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        // CupertinoIcons.clock,
                        Icons.punch_clock,
                        color: Colors.white,
                        size: 17,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        "$currentTime",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: [
              Image.asset(
                "images/mapss.png",
                width: 450,
                height: 200,
              ),
              InkWell(
                onTap: () async {
                  Position position = await _determinePosition();
                  print(" LAT IS ${position.latitude}");
                  print(" LAT IS ${position.latitude}");
                  lat = position.latitude.toString();
                  long = position.longitude.toString();
                  print('long $long');
                  print('lat $long');
                },
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 60, horizontal: 100),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color(0xff6F15DE),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                      child: Icon(
                        // CupertinoIcons.location,
                        Icons.location_on_sharp,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(height: 200, child: AspectRatioVideo(_controller)),
          ),
          SizedBox(
            height: 20.h,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            // margin: EdgeInsets.symmetric(horizontal:20),
            padding: EdgeInsets.all(10),
            child: DropdownButton(
              hint: Text('Choose Folder'),
              underline: Divider(
                thickness: 0,
              ),
              isExpanded: true,
              onChanged: (value) {
                value as Data;
                setState(() {
                  selected = value;
                  selectedFolderId = value.id ?? 0;
                  print(selectedFolderId);
                });
              },
              value: selected,
              items: folders
                  .map((e) => DropdownMenuItem(
                        child: Text("${e.name}"),
                        value: e,
                      ))
                  .toList(),
            ),
          ),
          Container(
            height: 70,
            margin: const EdgeInsets.symmetric(
              horizontal: 35,
            ),
            child: TextField(
              controller: _commentController,
              // keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: ' Write Comment!',
                  suffixIcon: IconButton(
                    icon: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: secondaryColor,
                      ),
                      child: const Icon(
                        // CupertinoIcons.arrow_left_circle,
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  labelStyle: TextStyle(
                      fontSize: 16.sp,
                      fontStyle: FontStyle.italic,
                      color: Color(0xff888888),
                      fontWeight: FontWeight.w500),
                  fillColor: Color(0xffFAFAFA),
                  filled: true,
                  helperMaxLines: 2,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xffc6cad4), width: 1.w),
                    borderRadius: BorderRadius.circular(27).r,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color(0xff50535c), width: 1.w),
                    borderRadius: BorderRadius.circular(27).r,
                  ),
                  constraints: BoxConstraints(
                    maxHeight: 372.h,
                    minWidth: 53.w,
                  )), // decoration: InputDecoration(
              //     prefix: Icon(
              //       Icons.sms,
              //       color: primaryColor,
              //     ),
              //     suffix: IconButton(
              //       onPressed: () {},
              //       icon: Icon(Icons.send),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderSide: BorderSide(width: 1, color: Colors.grey),
              //       borderRadius: BorderRadius.circular(40),
              //     ),
              //     hintText: "Enter YOUR PRICE",
              //     labelStyle:
              //         TextStyle(color: primaryColor, fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _playVideo(XFile? file) async {
    if (file != null && mounted) {
      print("Loading Video");
      await _disposeVideoController();
      late VideoPlayerController controller;
      /*if (kIsWeb) {
        controller = VideoPlayerController.network(file.path);
      } else {*/
      controller = VideoPlayerController.file(File(file.path));
      //}

      _controller = controller;

      // In web, most browsers won't honor a programmatic call to .play
      // if the video has a sound track (and is not muted).
      // Mute the video so it auto-plays in web!
      // This is not needed if the call to .play is the result of user
      // interaction (clicking on a "play" button, for example).

      //await controller.setVolume(volume);
      await controller.initialize();
      await controller.setLooping(true);
      if (played) {
        await controller.play();
      }
      setState(() async {
        played = true;
        await controller.pause();
      });
    } else {
      print("Loading Video error");
    }
  }

  Future<void> _disposeVideoController() async {
    /*  if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;*/
    if (_controller != null) {
      await _controller!.dispose();
    }
    _controller = null;
  }

  Future<void> getFolders() async {
    var response = await http
        .get(Uri.parse('http://176.126.87.26/api/main-folders'), headers: {
      'Authorization': 'Bearer ${SharedPrefController().token}',
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = await jsonDecode(response.body)['data'] as List;
      folders = data.map((e) => Data.fromJson(e)).toList();
    }
  }

  Future<void> getFileSize(XFile xFile, String type) async {
    xFile.readAsBytes().then((value) {
      if (value != null) {
        final kb = value.lengthInBytes / 1024;
        var mb = kb / 1024;
        size = mb;
        if (type == "image") {
          print("IMAGE SIZE KB: $kb");
          print("IMAGE  SIZE MB: $mb");
        } else {
          print("VIDEO SIZE KB: $kb");
          print("VIDEO  SIZE MB: $mb");
        }
      }
    });
  }

  Future<void> uploadFile(String file, String type, double size, int folderId,
      double lat, double long, String comment) async {
    print("CLICK ${file}");
    print("CLICK ${type}");
    print("CLICK ${size}");
    print("CLICK ${folderId}");
    print("CLICK ${lat}");
    print("CLICK ${long}");
    print("CLICK ${comment}");

    // static Future<void> captainRegister({required File captain}) async {
    // String code = PreferencesManager.getAppData(key: Const.KEY_COUNTRY_CODE);
    // double latitude = PreferencesManager.getAppData(key: Const.KEY_LATITUDE);
    // double longitude = PreferencesManager.getAppData(key: Const.KEY_LONGITUDE);
    var url = Uri.parse(ApiSettings.uploadimage); //
    String token = SharedPrefController().token; //

    // var request = http.MultipartRequest(
    //     ApiHelper.POST, ApiHelper.getUrl(url));
    // request.headers.addAll({
    //   HttpHeaders.authorizationHeader:
    //   'Bearer ${PreferencesManager.getCaptainToken(key: Const.KEY_CAPTAIN_TOKEN)}'
    // });

    var request = http.MultipartRequest("POST", url);
    request.headers.addAll({HttpHeaders.authorizationHeader: token});

    request.files.add(await http.MultipartFile.fromPath('file', file,
        filename: file.split('/').last));
    request.fields['type'] = type;
    request.fields['size'] = '$size';
    request.fields['lat'] = lat.toString();
    request.fields['long'] = long.toString();
    request.fields['comment'] = comment;
    request.fields['folder'] = folderId.toString();
    var response = await request.send();
    var responseBody = await http.Response.fromStream(response);
    responseBody.body;

    if (responseBody.statusCode == 200) {
      var body = jsonDecode(responseBody.body);
      showToast(message: 'Upload sucess post', color: Colors.green);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BootomNaviagtionScreen()));
      // print("SUCCESS captainRegister: ${jsonEncode(body)}");
    } else
      print("ERROR: captainRegister: ${jsonEncode(responseBody.body)}");
  }

  void showToast({required String message, Color color = Colors.black}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
