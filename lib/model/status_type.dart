import 'package:flutter/material.dart';

class StatusType{
  String statusCode;
  String statusValue;
  Color statusColor = Colors.white;

  StatusType(this.statusCode){
    if(statusCode == 'WAITING'){
      this.statusValue = 'កំពុងរងចាំ';
      this.statusColor = Colors.amber;
    }
    else if(statusCode == 'ACCEPT'){
      this.statusValue = 'ទិញហើយ';
      this.statusColor = Colors.green;
    }
    else if(statusCode == 'REJECT'){
      this.statusValue = 'ទិញមិនបាន';
      this.statusColor = Colors.redAccent;
    }
  }

}