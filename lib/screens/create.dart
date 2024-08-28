// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:event_app/constants/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class CreateEventPage extends StatefulWidget {
 

  CreateEventPage();

  @override
  _CreateEventPageState createState() => _CreateEventPageState();
  
 
}

class _CreateEventPageState extends State<CreateEventPage> {
 
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _descriptionController=TextEditingController();
  final _ticketController=TextEditingController();
final ImagePicker _picker = ImagePicker();
  File? _image;
  // ignore: unused_field
  bool _isUploading = false;
  @override
  void initState() {
    _timeController;
    _dateController;
    _descriptionController;
    _ticketController;
    _locationController;
    _titleController;
    super.initState();
  }

  @override
  void dispose() {
    _timeController.dispose();
    _dateController.dispose();
    _descriptionController.dispose();
    _ticketController.dispose();
    _locationController.dispose();
    _titleController.dispose();
    super.dispose();
  }

 Future<void> _pickImage(source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
Future<void> uploadPost() async {
  if (_image == null) return;

  setState(() {
    _isUploading = true;
  });

  String ticket = _ticketController.text.trim();
  String title = _titleController.text.trim(); 
  String date = _dateController.text.trim();
  String time = _timeController.text.trim();
  String description = _descriptionController.text.trim(); 
  String venue = _locationController.text.trim();

  try {
    final uri = Uri.parse(API.postEVent); // Ensure correct API endpoint
    final request = http.MultipartRequest('POST', uri);
    
    // Add the image file
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

    // Add other form fields
    request.fields['event_title'] = title;
    request.fields['date'] = date;
    request.fields['time'] = time;
    request.fields['venue'] = venue;
    request.fields['ticket_cost'] = ticket;
    request.fields['description'] = description;
    request.fields['created_by'] = "18";

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      final result = json.decode(responseData);
      
      Fluttertoast.showToast(msg: result['message']);
      print(result['message']);
    } else {
      Fluttertoast.showToast(msg: 'Failed to upload your post');
      print('Failed to upload post: ${response.statusCode}');
    }
  } catch (e) {
    print('Error occurred: $e');
    Fluttertoast.showToast(msg: 'Error occurred while uploading post');
  } finally {
    setState(() {
      _isUploading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text('Create Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Card(
              elevation: 3,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  
                    style: const TextStyle(color:Colors.black),
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Event Title' , labelStyle: TextStyle(color:Colors.red),border: InputBorder.none,),
                 
                ),
              ),
            ),
            Card(
              elevation: 3,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextField(
                  textInputAction: TextInputAction.next,
                    
                      style: const TextStyle(color:Colors.black),
                    controller: _locationController,
                    decoration: const InputDecoration(labelText: 'Venue' , labelStyle: TextStyle(color:Colors.red),border: InputBorder.none,),
                ),
              ),
            ),
            Card(
              elevation: 3,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                  onTap: _showDatePicker(),
                  child: AbsorbPointer(
                    child: TextField(
                       textInputAction: TextInputAction.next,
                        
                          style: const TextStyle(color:Colors.black),
                        controller: _dateController,
                        decoration: const InputDecoration(labelText: 'Date' , labelStyle: TextStyle(color:Colors.red),border: InputBorder.none,),
                      
                    ),
                  ),
                ),
              ),
            ),
             Card(
      elevation: 3,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: GestureDetector(
          onTap: () => _selectTime(context),
          child: AbsorbPointer(
            child: TextField(
              textInputAction: TextInputAction.next,
              style: const TextStyle(color: Colors.black),
              controller: _timeController,
              decoration: const InputDecoration(
                labelText: 'Time',
                labelStyle: TextStyle(color: Colors.red),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    ),
       Card(
              elevation: 3,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: TextField(
                  textInputAction: TextInputAction.next,
                    
                      style: const TextStyle(color:Colors.black),
                    controller: _ticketController,
                    decoration: const InputDecoration(labelText: 'Ticket cost' , labelStyle: TextStyle(color:Colors.red),border: InputBorder.none,),
                ),
              ),
            ),
    SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            _pickImage(ImageSource.gallery);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[900],
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'GALLERY',
                                style: TextStyle(color: Colors.white),
                              ),
                               SizedBox(width: 10),
                              Icon(
                                Icons.image,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _pickImage(ImageSource.camera);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[900],
                          ),
                          child:const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('CAMERA',
                                  style: TextStyle(color: Colors.white)),
                              SizedBox(width: 6),
                              Icon(Icons.camera_alt, color: Colors.white)
                            ],
                          ),
                        ),
                      ],
                    ),  ),),
              
          
        
           const  SizedBox(height: 20),
           ///select image button
            _image == null
              ? 
            Column(
              children: [
                Container(
                  color: Colors.red[900],
                  height: 150,
                  width: 250,
                  child: Center(child: IconButton(onPressed: (){}, icon: const Icon(Icons.image,size: 150,)))),
              ],
            ):
              Expanded(
                  child: Container(
                    height: 400,
                    width: double.infinity,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.file(
                        _image!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
           const  SizedBox(height: 20),
////Event description

            Card(
              elevation: 3,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Flexible(
                  child: TextField(
                    maxLines: 10,
                    textInputAction: TextInputAction.next,
                    
                      style: const TextStyle(color:Colors.black),
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Event Description' , labelStyle: TextStyle(color:Colors.red),border: InputBorder.none,),
                   
                  ),
                ),
              ),
            ),


             const SizedBox(height: 20,),
           /////create button
            MaterialButton(
              height: 50,
              elevation: 30,
              color: Colors.red[900],
              onPressed: () {
                uploadPost().then((value) => Navigator.pop(context));
          //       setState(() {
          //         _ticketController.clear();
          //         _dateController.clear();
          //         _titleController.clear();
          //         _locationController.clear();
          //         _dateController.clear();
          //         _timeController.clear();
          //          _descriptionController.clear();
                  
          //       });
          //         Fluttertoast.showToast(
          //   msg: "Event created successfully",
          //   toastLength: Toast.LENGTH_SHORT,
          //   gravity: ToastGravity.BOTTOM,
          //   timeInSecForIosWeb: 1,
          //   backgroundColor:Colors.green,
          //   textColor: Colors.white,
          //   fontSize: 16.0,
          // );
              },
              child: const Text('Create Event', style: TextStyle(color:Colors.white,fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
 
 ///time_picker
 _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = picked.format(context);
      });
    }
  }

  ///date_picker
  
  _showDatePicker() {}

  ///postEvent method
  void _postEventold()async {
        String ticket=_ticketController.text.trim();
        String title=_titleController.text.trim(); 
        String date= _dateController.text.trim();
        String time=_timeController.text.trim();
        String description=_descriptionController.text.trim(); 
        String venue= _locationController.text.trim();
        File? image;


        Fluttertoast.showToast(msg: "creating post");
        try{
            var post= await http.post(Uri.parse(API.postEVent),
             body: {
              'ticket_cost':ticket,
              'event_title':title,
              'date':date,
              'time':time,
              'description':description,
              'venue':venue,
              'image':image
              

             }
     );
     if(post.statusCode==200){
      var postbody=jsonDecode(post.body);
      if(postbody['sucess']==true){
        Fluttertoast.showToast(msg: "Event created successfully").then((value) => 
        Navigator.pop(context)
        
        );
      }else{
         Fluttertoast.showToast(msg: "Failed to create event");

      }
     }
    
     
}catch(e){
    print(e.toString());
    Fluttertoast.showToast(msg: e.toString());

        }

  }
}