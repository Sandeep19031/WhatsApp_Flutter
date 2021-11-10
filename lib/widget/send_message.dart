import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
class SendMessage extends StatelessWidget {
  
  final String msg;
  final String timestamp;
  final bool lastMsgByMe;
  SendMessage({
    Key? key,
    required this.msg,
    required this.timestamp,
    required this.lastMsgByMe
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // return Container(
    //           padding: lastMsgByMe ? EdgeInsets.only(top: 3) : EdgeInsets.only(top: 7),
    //           margin: lastMsgByMe ? EdgeInsets.only(right: 20): EdgeInsets.only(right: 0),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Flexible(
    //                   child: Container(
                      
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.only(
    //                         bottomLeft: Radius.circular(5),
    //                         bottomRight: Radius.circular(5),
    //                         topLeft: Radius.circular(5),
    //                         topRight: lastMsgByMe ? Radius.circular(5) : Radius.circular(0)
    //                       ),
    //                       color: HexColor("#e1ffc7"),

    //                   ),
    //                   constraints: BoxConstraints(
    //                     maxWidth: 300,
    //                   ),
    //                   child: Row(
    //                       mainAxisSize: MainAxisSize.min, 
    //                       mainAxisAlignment: MainAxisAlignment.end,              
    //                       children: [
    //                       Text(
    //                         msg,    
    //                         textAlign: TextAlign.start,
    //                         overflow: TextOverflow.ellipsis,
    //                         softWrap: true,
    //                         maxLines: 10,
    //                         style: TextStyle(
    //                           fontSize: 17,
    //                           fontFamily: 'HelveticaNeue Light',
    //                           fontWeight: FontWeight.w400,
    //                         ),
    //                       ),
    //                       SizedBox(width: 10,),
    //                       Row(
    //                       crossAxisAlignment: CrossAxisAlignment.end,
    //                       mainAxisSize: MainAxisSize.min,
    //                       children: [
    //                         Text(
    //                         DateFormat('kk:mm').format(
    //                           DateTime.fromMillisecondsSinceEpoch(
    //                         int.parse(timestamp))
    //                       ), 
    //                       style: TextStyle(
    //                         fontFamily: 'OpenSans',
    //                         fontSize: 12,
    //                         fontWeight: FontWeight.w600,   
    //                         color: Colors.grey[400],                           
    //                       ),      
                                               
    //                         ),
    //                         Icon(Icons.done_all,size: 18, color: Colors.blue)
    //                       ]
    //                         ),
    //                     ]
    //                   ),
    //                   padding: EdgeInsets.all(3),
    //                 ),
    //               ),
    //               if(!lastMsgByMe)
    //               Container(
    //                 width: 0,
    //                 height: 0,
    //                 margin: EdgeInsets.symmetric(horizontal: 10),
    //                 decoration: BoxDecoration(
    //                   border: Border(
    //                     right: BorderSide(
    //                       width: 10,
    //                       color: HexColor("#e1ffc7")
    //                     ),
    //                     top: BorderSide(
    //                       width: 10,
    //                       color: Colors.black.withOpacity(0),
    //                     ),
    //                   ),
    //                 ),
    //               ),
                  
                  
    //           ]
    //           ),
    //       );
    return Container(
      padding: lastMsgByMe ? EdgeInsets.only(top: 3) : EdgeInsets.only(top: 7),
      margin: lastMsgByMe ? EdgeInsets.only(right: 20): EdgeInsets.only(right: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
               decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                      topLeft: Radius.circular(5),
                      topRight: lastMsgByMe ? Radius.circular(5) : Radius.circular(0)
                    ),
                    color: HexColor("#e1ffc7"),

                ),
                constraints: BoxConstraints(
                  maxWidth: 300,
                ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                      child: Container(
                      padding: EdgeInsets.all(8),
                      child: Text(msg,
                           textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 10,
                            style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                          ),
                      )
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    padding: EdgeInsets.only(right: 3,bottom: 3),
                    child: Row(
                      children: [
                         Text(
                            DateFormat('kk:mm').format(
                              DateTime.fromMillisecondsSinceEpoch(
                            int.parse(timestamp))
                          ), 
                          style: TextStyle(
                            fontFamily: 'OpenSans',
                            fontSize: 12,
                            fontWeight: FontWeight.w600,   
                            color: Colors.grey[400],                           
                          ),     
                         ),
                         Icon(Icons.done_all,size: 18, color: Colors.blue)
                      ],
                    ),
                  ),
                
              ],),),
          
          if(!lastMsgByMe)
            Container(
              width: 0,
              height: 0,
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border(
                  right: BorderSide(
                    width: 10,
                    color: HexColor("#e1ffc7")
                  ),
                  top: BorderSide(
                    width: 10,
                    color: Colors.black.withOpacity(0),
                  ),
                ),
              ),
            ),
        ]
      ),
    );
  }
}