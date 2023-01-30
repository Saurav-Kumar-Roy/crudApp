import 'dart:convert';
import 'package:appwithapi/Utility/Utility.dart';
import 'package:http/http.dart' as http;

Future<bool> ProductCreateRequest(FormValues) async {
  var URL=Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct");
  var PostBody=json.encode(FormValues);
  var PostHeader = {"Content-Type":"application/json"};

  var response=await http.post(URL,headers:PostHeader,body:PostBody);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);

  if(ResultCode==200 && ResultBody['status']=="success"){
    SuccessToast("success");
    return true;
  }
  else{
    ErrorToast("Faild try again");
    return false;
  }
  
}

Future<List> ProductGridViewReadRequest() async{
  var URL = Uri.parse("https://crud.teamrabbil.com/api/v1/ReadProduct");
  var PostHeader = {"Content-Type":"application/json"};

  var response = await http.get(URL,headers: PostHeader);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);

  if(ResultCode==200 && ResultBody['status']=="success"){
    SuccessToast("Data receved.");
    return ResultBody['data'];
  }
  else{
    ErrorToast("Faild to recive. try again");
    return [];
  }

}

Future<bool> ProductDeleteRequest(id) async{
  var URL = Uri.parse("https://crud.teamrabbil.com/api/v1/DeleteProduct/"+id);
  var PostHeader = {"Content-Type":"application/json"};

  var response=await http.get(URL,headers:PostHeader);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);

  if(ResultCode==200 && ResultBody['status']=="success"){
    SuccessToast("Delete SuccessFull");
    return true;
  }
  else{
    ErrorToast("Faild to delete. try again");
    return false;
  }

}

Future<bool> ProductUpdateRequest(FormValues,id) async {
  var URL=Uri.parse("https://crud.teamrabbil.com/api/v1/UpdateProduct/"+id);
  var PostBody=json.encode(FormValues);
  var PostHeader = {"Content-Type":"application/json"};

  var response=await http.post(URL,headers:PostHeader,body:PostBody);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);

  if(ResultCode==200 && ResultBody['status']=="success"){
    SuccessToast("success");
    return true;
  }
  else{
    ErrorToast("Faild try again");
    return false;
  }
  
}