

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
     
     /// write the expiration date into shared preferences
     writeSharedDate(int expirationDate) async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setInt('expirationDate', expirationDate);
          print('Expiration Date is written into shared preffs');
     }

     /// read the expiration date
     readSharedDate(int expirationDateFromShared) async {
       final prefs = await SharedPreferences.getInstance();
       expirationDateFromShared = prefs.getInt('expirationDate') ?? 0;
       return expirationDateFromShared;
     }


}