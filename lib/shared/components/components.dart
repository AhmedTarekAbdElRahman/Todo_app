import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/shared/cubit/cubit.dart';

Widget defaultButton({
  required double? width,
  required Color? background,
  required VoidCallback? function,
  required String? text,

}) =>
    Container(
      height: 40.0,
      decoration:BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(4),
      ),
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          text!.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController? controller,
  required TextInputType? type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  bool isPassword = false,
  required FormFieldValidator<String>? validate,
  required String? label,
  required IconData? prefix,
  IconData? suffix,
  VoidCallback?suffixPress,
  GestureTapCallback? onTap,
  bool isClickable=true,
}) =>
    TextFormField(
      enabled: isClickable,
      onTap: onTap,
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed:suffixPress,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
      ),
      validator: validate,
    );
Widget buildTaskItem(Map model,context)=>Dismissible(
  key: Key(model['id'].toString()),
  onDismissed: (direction) {
    AppCubit.get(context).deleteData(id: model['id']);
  },
  child:   Padding(
  
    padding: const EdgeInsets.all(20.0),
  
    child: Row(
  
      children: [
  
        CircleAvatar(
  
          radius: 40.0,
  
          child: Text(
  
            '${model['time']}',
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20.0,
  
        ),
  
        Expanded(
  
          child: Column(
  
            crossAxisAlignment: CrossAxisAlignment.start,
  
            mainAxisSize: MainAxisSize.min,
  
            children: [
  
              Text(
  
                '${model['title']}',
  
                style: TextStyle(
  
                  fontSize: 18.0,
  
                  fontWeight: FontWeight.bold,
  
                ),
  
              ),
  
              Text(
  
                '${model['date']}',
  
                style: TextStyle(
  
                  color: Colors.grey,
  
                ),
  
              ),
  
            ],
  
          ),
  
        ),
  
        SizedBox(
  
          width: 20.0,
  
        ),
  
        IconButton(
  
            onPressed: (){
  
              AppCubit.get(context).updateData(status: 'done', id: model['id']);
  
            },
  
            icon:Icon(
  
              Icons.check_box_rounded,
  
            color: Colors.green,
  
            ) ),
  
        IconButton(
  
            onPressed: (){
  
              AppCubit.get(context).updateData(status: 'archive', id: model['id']);
  
            },
  
            icon:Icon(
  
                Icons.archive,
  
              color: Colors.black26,
  
            ) ),
  
      ],
  
    ),
  
  ),
);

Widget myDivider()=>Padding(
  padding: const EdgeInsets.only(left: 20.0),
  child:   Container(

    width: double.infinity,

    color: Colors.grey[300],

    height: 1.0,

  ),
);
void navigateTO(context,widget)=>Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
  );

void navigateAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
    (Route<dynamic> route)=>false

);
void showtoast({
  required String text,
  required ToastStates state
})=>Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates{SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
       color=Colors.green;
      break;
    case ToastStates.ERROR:
       color=Colors.red;
      break;
    case ToastStates.WARNING:
      color=Colors.yellow;
      break;
  }
  return color;
}
