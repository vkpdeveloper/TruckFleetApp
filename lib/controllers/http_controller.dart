import 'package:dio/dio.dart';
import 'package:flutter_learning_app/controllers/local_storage_controller.dart';
import 'package:flutter_learning_app/models/booked_load.dart';
import 'package:flutter_learning_app/models/load.dart';
import 'package:flutter_learning_app/models/user.dart';
import 'package:flutter_learning_app/providers/login.dart';

class HttpController {
  static String _hostUrl = "http://10.0.2.2:3000";

  static Future<bool> postProfile(LoginProvider provider) async {
    String endPoint = "/register";
    FormData formData = FormData.fromMap({
      "name": provider.name,
      "email": provider.email,
      "mobile": provider.phone,
      "aadhaar": MultipartFile.fromFile(provider.aadhaar.path),
      "pan": MultipartFile.fromFile(provider.pan.path),
      "location": provider.location,
      "company_name": provider.companyName
    });
    Response response = await Dio().post("$_hostUrl$endPoint",
        data: formData, options: Options(contentType: "application/json"));
    if (response.data['success']) {
      LocalStorageUtils().addUserAuthToken(response.data['response']['_id']);
      return true;
    }
    return false;
  }

  static Future<bool> bookLoad(
      {bidAmount, amountType, negotiable, availability, fid}) async {
    String endPoint = "/book_load";
    Response response = await Dio().post("$_hostUrl$endPoint",
        data: {
          "bid_amount": bidAmount,
          "amount_type": amountType,
          "negotiable": negotiable,
          "availability": availability,
          "fid": fid,
          "uid": LocalStorageUtils().getAuthToken()
        },
        options: Options(contentType: "application/json"));
    print(response.data);
    if (response.data['success']) {
      return true;
    }
    return false;
  }

  static Future<bool> attachFleet(
      {pickUpLocation,
      dropLocation,
      truckNumber,
      fleetRate,
      fleetCapacity,
      fleetType}) async {
    String endPoint = "/add_fleet";
    Response response = await Dio().post("$_hostUrl$endPoint",
        data: {
          "pickup_location": pickUpLocation,
          "drop_location": dropLocation,
          "truck_number": truckNumber,
          "fleet_rate": int.tryParse(fleetRate),
          "fleet_capacity": fleetCapacity,
          "fleet_type": fleetType,
          "uid": LocalStorageUtils().getAuthToken()
        },
        options: Options(contentType: "application/json"));
    print(response.data);
    if (response.data['success']) {
      return true;
    }
    return false;
  }

  static Future<List<Load>> getAllLoads() async {
    try {
      var endPoint = "/get_load";
      Response response = await Dio().get("$_hostUrl$endPoint");
      List<Load> allLoads = List<Load>();
      if (response.data.containsKey("data")) {
        for (var item in response.data['data']) {
          Load load = Load.fromJson(item);
          allLoads.add(load);
        }
        return allLoads;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<List<BookedLoad>> getBookedHistory() async {
    var endPoint = "/get_bookLoad";
    try {
      Response res = await Dio().get("$_hostUrl$endPoint",
          options:
              Options(headers: {"uid": LocalStorageUtils().getAuthToken()}));
      List<BookedLoad> allLoads = List<BookedLoad>();
      if (res.data.containsKey("data")) {
        for (var item in res.data['data']) {
          BookedLoad load = BookedLoad.fromJson(item);
          allLoads.add(load);
        }
        return allLoads;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<User> getUserProfile() async {
    var endPoint = "/profile";
    try {
      Response res = await Dio().get("$_hostUrl$endPoint",
          options:
              Options(headers: {"uid": LocalStorageUtils().getAuthToken()}));
      if (res.data.containsKey("data")) {
        User user = User.fromJson(res.data['data']['response']);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<User> checkUserProfile(String phoneNumber) async {
    var endPoint = "/check_profile";
    try {
      Response res =
          await Dio().post("$_hostUrl$endPoint", data: {"mobile": phoneNumber});
      if (res.data.containsKey("data")) {
        User user = User.fromJson(res.data['data']['response']);
        LocalStorageUtils().addUserAuthToken(user.sId);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
