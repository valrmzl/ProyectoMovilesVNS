import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Balance extends StatelessWidget {
  const Balance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(height: 320,child: _head()),),
            SliverToBoxAdapter(
              child:
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text("Historial de transacciones", style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 19,
                                color: Colors.black)
                                ),
                  Text("Ver todo", style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.grey)
                                ),
                             ]
                             ),
               ),
            )
          ],
        )
        ),
    );
  }   

  Widget _head(){
    return Stack(children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 180,
                decoration:
                  BoxDecoration(color: Color.fromARGB(255, 22, 165, 110),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)
                  )
                  ),
                  child: Stack(children: [
                    Positioned(
                      top: 35,
                      left: 430,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Container( height: 40, width: 40,
                        color: Color.fromARGB(255, 129, 241, 204),
                        child: Icon(
                          Icons.notification_add,
                          size: 30,
                          color: Colors.white,)
                          ,),
                      )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left:10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Buenas tares", style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white)
                              ),
                              Text("Valeria Ramirez", style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.white)
                              ),
                          ],
                        ),
                      )
                  ]),
              ),
            ],
          ),
          Positioned(
            top:130,
            left: 70,
            child: Container(
              height: 170,
              width: 380,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(47, 125, 121, 0.3),
                    offset: Offset(0,6),
                    blurRadius: 12,
                    spreadRadius: 6,

                  )
                ],
                color: Color.fromARGB(255, 47, 125, 121),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(children: [
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text("Balance Total", 
                      style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: Colors.white),
                    ),
                    Icon(Icons.more_horiz, color: Colors.white)
                  ],),
                ),
                SizedBox(height: 7,),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Row(children: [
                    Text('\$ 1,400',
                             style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  color: Colors.white)
                    ),
                
                  ],),
                ),
                SizedBox(height: 25,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: Color.fromARGB(255, 85, 145, 141),
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                              size: 19,),
                          ),
                          SizedBox(width: 7,),
                          Text("Ingresos", style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.white)
                           ),
                        ],
                      ),
                       Row(
                        children: [
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: Color.fromARGB(255, 85, 145, 141),
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                              size: 19,),
                          ),
                          SizedBox(width: 7,),
                          Text("Egresos", style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.white
                              ),
                           ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 6,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                
                    Text('\$ 1,400',
                               style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    color: Colors.white)
                      ),
                      Text('\$ 1,400',
                               style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    color: Colors.white)
                      ),
                  ],),
                )
              ]),
            ),
          )

        ],
        ) ;
  }
}
