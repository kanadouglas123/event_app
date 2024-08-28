import 'package:event_app/Model/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RememberUser {
  static Future<void> saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', user.id.toString());
    prefs.setString('username', user.username);
    prefs.setString('email', user.email);
  }

   Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id');
  }

 Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username');
  }

  Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('id') && prefs.containsKey('username');
  }

 Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('id');
    prefs.remove('username');
  }
  Future<void>saveEvent(save) async{
    SharedPreferences eventSaved = await SharedPreferences.getInstance();
     eventSaved.setString('id', save.id.toString());
     eventSaved.setString('event_title', save.title);
     eventSaved.setString('venue', save.venue);
     eventSaved.setString('date', save.date);
     eventSaved.setString('time', save.time);
     eventSaved.setString('ticket_cost', save.cost);
     eventSaved.setString('description', save.description);
      eventSaved.setString('image', save.image);



  }
}