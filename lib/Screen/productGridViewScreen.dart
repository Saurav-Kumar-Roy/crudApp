import 'package:appwithapi/Screen/productCreateScreen.dart';
import 'package:appwithapi/Screen/productUpdateScreen.dart';
import 'package:flutter/cupertino.dart';

import 'package:appwithapi/RestAPI/RestClient.dart';
import 'package:appwithapi/Style/style.dart';
import 'package:flutter/material.dart';
import "package:appwithapi/Utility/Utility.dart";


class ProductGridViewScreen extends StatefulWidget{
  const ProductGridViewScreen({Key?key}):super (key:key);
  State<ProductGridViewScreen> createState()=>_ProductGridViewScreenState();
}

class _ProductGridViewScreenState extends State<ProductGridViewScreen>{

  List Productlst=[];
  List ProductList=[];
  bool isloading=true;


  void initState(){
    CallData();
    super.initState();
  }

  CallData() async{
    isloading=true;
    var data = await ProductGridViewReadRequest();
    setState(() {
      ProductList=[];
      Productlst = data;
      int n = Productlst.length;
      print(n);
      for(int i=0;i<n;i++){
        
        if(Productlst[i]['Img']!=null &&
        Productlst[i]['ProductCode']!=null &&
        Productlst[i]['ProductName']!=null && 
        Productlst[i]['Qty']!=null&&
        Productlst[i]['TotalPrice']!=null&&
        Productlst[i]['UnitPrice']!=null
        ){
          ProductList.add(Productlst[i]);
        }
        
        //if(!Productlst[i].containsValue(Null)){
         // ProductList.add(Productlst[0]);
        //} 
      }
      print(Productlst[0]);
      isloading = false;
    });
  }
    

  DeleteItem(id)async{
    showDialog(
      context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          title:Text("Delete !"),
          content: Text("Sure to delete?"),
          actions: [
            OutlinedButton(onPressed: ()async{
                Navigator.pop(context);
                setState(() {
                  isloading=true;
                });
                await ProductDeleteRequest(id);
                await CallData();
                
              }, 
              child: Text("Yes."),
            ),
            OutlinedButton(onPressed: (){
                Navigator.pop(context);
              }, 
              child: Text("No."),
            ),
          ],
        );
      }
    );
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title:Text("List Product"),),
      body:Stack(
        children: [
          ScreenBackground(context),
          Container(
            child: isloading?(Center(child: CircularProgressIndicator(),)):RefreshIndicator(
              onRefresh: ()async{
                await CallData();
              },
              child: GridView.builder(
                gridDelegate: ProductGridViewStyle(), 
                itemCount:ProductList.length,
                itemBuilder: (context,index){
                  return Card(
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(child: Image.network(ProductList[index]['Img'],fit:BoxFit.fill)),
                        Container(
                          padding: EdgeInsets.fromLTRB(5,5,5,8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(ProductList[index]['ProductName']),
                              SizedBox(height:7),
                              Text("Price: "+ProductList[index]['UnitPrice']+"`BDT"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  OutlinedButton(onPressed: (){
                                      Navigator.push(context,
                                        MaterialPageRoute(builder:(builder)=>productUpdateScreen(ProductList[index]))
                                      );
                                    }, 
                                    child: Icon(CupertinoIcons.ellipsis_vertical_circle,color: colorGreen,size: 18,),
                                  ),
                                  SizedBox(width: 4,),
                                  OutlinedButton(onPressed: (){
                                      DeleteItem(ProductList[index]['_id']);
                                    }, 
                                    child: Icon(CupertinoIcons.delete,color:colorRed,size:18),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                      
                    ),
                  );
                }
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context,
            MaterialPageRoute(builder:(builder)=>productCreateScreen())
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}