import 'package:appwithapi/RestAPI/RestClient.dart';
import 'package:appwithapi/Screen/productGridViewScreen.dart';
import 'package:appwithapi/Style/style.dart';
import 'package:flutter/material.dart';
import "package:appwithapi/Utility/Utility.dart";

class productUpdateScreen extends StatefulWidget{
  final Map productItem;
  const productUpdateScreen(this.productItem);

  State<productUpdateScreen> createState()=>_State();
}

class _State extends State<productUpdateScreen>{
  

  bool loading = false;
  
  Map<String,String> FormValues={
    "Img":"",
    "ProductCode":"",
    "ProductName":"",
    "Qty":"",
    "TotalPrice":"",
    "UnitPrice":""
  };

  void initState(){
    setState(() {
      FormValues.update("Img",(value)=>widget.productItem['Img']);
      FormValues.update("ProductCode",(value)=>widget.productItem['ProductCode']);
      FormValues.update("ProductName",(value)=>widget.productItem['ProductName']);
      FormValues.update("Qty",(value)=>widget.productItem['Qty']);
      FormValues.update("TotalPrice",(value)=>widget.productItem['TotalPrice']);
      FormValues.update("UnitPrice",(value)=>widget.productItem['UnitPrice']);
    });
    
  }

  InputOnChange(key,Tvalue){
    setState(() {
      FormValues.update(key, (value) => Tvalue);
    });
  }

  FormOnSubmit() async{
    if(FormValues['Img']!.length==0){
      ErrorToast("Image like needed");
    }
    else if(FormValues['ProductCode']!.length==0){
      ErrorToast("Code needed");
    }
    else if(FormValues['ProductName']!.length==0){
      ErrorToast("Name needed");
    }
    else if(FormValues['Qty']!.length==0){
      ErrorToast("Qty needed");
    }
    else if(FormValues['TotalPrice']!.length==0){
      ErrorToast("Price needed");
    }
    else if(FormValues['UnitPrice']!.length==0){
      ErrorToast("Unit Price needed");
    }
    else{
      setState(() {
        loading=true;
      });
      await ProductUpdateRequest(FormValues,widget.productItem['_id']);
      Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context)=>ProductGridViewScreen()),
        (Route route)=>false
      );

      setState(() {
        loading=false;
      });
    }
  }
  
   Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product"),
      ),
      body:Stack(
        children: [
          ScreenBackground(context),
          Container(
            child:loading?(Center(child: CircularProgressIndicator(),)):(
              SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child:Column(
                  children: [
                    TextFormField(
                      initialValue: FormValues['ProductName'],
                      onChanged: (value){
                        InputOnChange("ProductName", value);
                      },
                      decoration: AppInputDecoraton("Product Name"),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      initialValue: FormValues['ProductCode'],
                      onChanged: (value){InputOnChange("ProductCode", value);},
                      decoration: AppInputDecoraton("Product Code"),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      initialValue: FormValues['Img'],
                      onChanged: (value){InputOnChange("Img", value);},
                      decoration: AppInputDecoraton("Product Image"),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      initialValue: FormValues['UnitPrice'],
                      onChanged: (value){InputOnChange("UnitPrice", value);},
                      decoration: AppInputDecoraton("Unit Price"),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      initialValue: FormValues['TotalPrice'],
                      onChanged: (value){InputOnChange("TotalPrice", value);},
                      decoration: AppInputDecoraton("Total Price"),
                    ),
                    SizedBox(height: 20,),
                    AppDropDownStyle(
                      DropdownButton(
                        value:FormValues['Qty'],
                        items: [
                          DropdownMenuItem(child:Text('Select qt'),value: '',),
                          DropdownMenuItem(child:Text('1 piece'),value: '1 piece',),
                          DropdownMenuItem(child:Text('2 piece'),value: '2 piece',),
                          DropdownMenuItem(child:Text('3 piece'),value: '3 piece',),
                        ],
                      onChanged: (Value){
                          InputOnChange("Qty", Value);
                        },
                        underline: Container(),
                        isExpanded: true,
                      ),
                    ),
                    SizedBox(height:20),
                    Container(
                      child:ElevatedButton(
                        style:AppButtonstyle(),
                        onPressed: (){
                          FormOnSubmit();
                        }, 
                        child: SuccessButtonChild("Update"),
                      ), 
                    ),
                      
                  ],
                ),
              )
            ),
          ),
        ],
      ),
      
    );
  }
}