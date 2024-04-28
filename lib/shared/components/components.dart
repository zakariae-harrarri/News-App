import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';
Widget separator(){
  return Container(color: Colors.grey,height: 1,);
}

Widget itemNews({context,article}){
  return InkWell(
    onTap: (){
      navTO(context, WebViewScreen(article['url']));
    },
    child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 150,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage(article['urlToImage'].toString()),
            fit: BoxFit.cover,
          ),
        ),
      ),
    SizedBox(
    width: 20,
    ),
    Expanded(
    child: Container(
child: Column(
mainAxisSize: MainAxisSize.min,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
    article['title'].toString(),
maxLines: 3,
overflow: TextOverflow.ellipsis,
style: TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold
),),
Text(article['publishedAt'].toString().substring(0,10)),
],
),
),
),
],
),
),
  );
}


Widget defaultFormField({
  required TextEditingController controler,
  required TextInputType type,
  required String label,
  required IconData prefix,
  required String? Function(String?)? validate,
  String? Function(String?)? onSubmit,
  String? Function(String?)? onChange,
  String? Function()? tap,
  bool isPasswoard=false,
  bool visiblePasswoard=false,
  Function? suffixPressed,
  bool showCursor=true,
  bool readOnly=false,
})=>TextFormField(
  showCursor: showCursor,
  readOnly: readOnly,
  controller: controler,
  obscureText: isPasswoard ? visiblePasswoard : false,
  keyboardType: type,
  decoration: InputDecoration(
    labelText: label,
    border: OutlineInputBorder(),
    prefixIcon: Icon(prefix),
    //GestureDetector(child: Icon(Icons.remove_red_eye_outlined),onTap: (){print("tap");},),
    suffixIcon: isPasswoard ? IconButton(
      icon: visiblePasswoard ? Icon(Icons.visibility_outlined) : Icon(Icons.visibility_off_outlined),
      onPressed: ()=>suffixPressed!(),
    ):null,
  ),
  validator: validate,
  onChanged: onChange,
  onFieldSubmitted: onSubmit,
  onTap: tap,
);

void navTO(context,widget){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget,),
  );
}