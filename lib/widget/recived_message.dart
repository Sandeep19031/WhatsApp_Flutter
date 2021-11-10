import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReceivedMessage extends StatelessWidget {

  final String msg;
  final String timestamp;
  final bool lastMsgByMe;
  ReceivedMessage({required this.msg, required this.timestamp,required this.lastMsgByMe});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //           padding: lastMsgByMe ? EdgeInsets.only(top: 3) : EdgeInsets.only(top: 7),
    //           margin: lastMsgByMe ? EdgeInsets.only(left: 20): EdgeInsets.only(right: 0),
    //           child: Row(
                
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               if(!lastMsgByMe)
    //               Container(
    //                 width: 0,
    //                 height: 0,
    //                 margin: EdgeInsets.symmetric(horizontal: 10),
    //                 decoration: BoxDecoration(
    //                   border: Border(
    //                     left: BorderSide(
    //                       width: 10,
    //                       color: Colors.white
    //                     ),
    //                     top: BorderSide(
    //                       width: 10,
    //                       color: Colors.black.withOpacity(0),
    //                     ),
    //                   ),
    //                 ),
    //               ),
                  
    //               Flexible(
    //                   child: Container(
                      
    //                   decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.only(
    //                         bottomLeft: Radius.circular(5),
    //                         bottomRight: Radius.circular(5),
    //                         topRight: Radius.circular(5),
    //                         topLeft: lastMsgByMe ? Radius.circular(5) : Radius.circular(0)
    //                       ),
    //                       color: Colors.white,

    //                   ),
    //                   constraints: BoxConstraints(
    //                     maxWidth: 300,
    //                   ),
    //                   child: Row(
    //                       mainAxisSize: MainAxisSize.min, 
    //                       mainAxisAlignment: MainAxisAlignment.center,              
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
    //                       Container(
    //                         padding: EdgeInsets.only(top:  8),                            
    //                         child: Row(
    //                           crossAxisAlignment: CrossAxisAlignment.end,                            
    //                           children: [
    //                             Text(
    //                             DateFormat('kk:mm').format(
    //                               DateTime.fromMillisecondsSinceEpoch(
    //                             int.parse(timestamp))
    //                           ), 
    //                           style: TextStyle(
    //                             fontFamily: 'OpenSans',
    //                             fontSize: 12,
    //                             fontWeight: FontWeight.w600,   
    //                             color: Colors.grey[400],                           
    //                           ),      
                                                   
    //                         ),
                            
    //                           ]
    //                         ),
    //                       ),
    //                     ]
    //                   ),
    //                   padding: EdgeInsets.all(3),
    //                 ),
    //               ),
    //           ]
    //           ),
    //         );
    return Container(
      padding: lastMsgByMe ? EdgeInsets.only(top: 3) : EdgeInsets.only(top: 7),
      margin: lastMsgByMe ? EdgeInsets.only(left: 20): EdgeInsets.only(left: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if(!lastMsgByMe)
              Container(
                width: 0,
                height: 0,
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      width: 10,
                      color: Colors.white
                    ),
                    top: BorderSide(
                      width: 10,
                      color: Colors.black.withOpacity(0),
                    ),
                  ),
                ),
              ),
          Container(
               decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                      topLeft: Radius.circular(5),
                      topRight: lastMsgByMe ? Radius.circular(5) : Radius.circular(0)
                    ),
                    color: Colors.white,

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
                              fontFamily: 'HelveticaNeue Light',
                              fontWeight: FontWeight.w400,
                          ),
                      )
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    padding: EdgeInsets.only(right: 3,bottom: 3),
                    child: 
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
                      
                    ),
                  
                
              ],),),
          
          
        ]
      ),
    );
  }
}