import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MultiText extends StatelessWidget {
  String str, con;
  MultiText(this.str, this.con, {super.key});

  // const MultiText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.w),
      child: Row(
        children: [
          Expanded(
            flex: 0,
            child: Text(
              con,
              style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            width: 0.5.w,
          ),
          Expanded(
            flex: 2,
            child: Text(
              str,
              style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
