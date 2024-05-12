import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: size.height * 0.35,
              width: size.width,
              decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/images/favicon.png',
                        height: 60,
                      ),
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.white.withOpacity(.1),
                            width: 4,
                          ),
                          image: const DecorationImage(
                            image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQGTFQJsNvORDziLimBrg9ECLThvjAb9pEtTQ&s')
                            ,fit: BoxFit.cover)
                        ),
                      )
                    ],
                  ),
                  Text('Hello, Ashik!',
                  style: TextStyle(
                    color: Colors.white.withOpacity(.8),
                    fontSize: 18
                  ),
                  ),
                  Column(
                    children: [
                      Text('\$ 550.00',
                  style: TextStyle(
                    color: Colors.white.withOpacity(.8),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  const Text('Your Balance',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18
                  ),
                  ),
                    ],
                  )
                ],
                ),
              ),
            ),
            Padding(
             padding: const EdgeInsets.all(20.0),
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Row(
                children: [
                   Container(
                  height: 130,
                  width: size.width * .35,
                  color: Colors.red,
                ),
                 const SizedBox(
                  width: 20,
                ),
                Container(
                  height: 130,
                  width: size.width * .35,
                  color: Colors.red,
                )
                ],
               )
              ],
             ),
           )
          ],
        ),
      ),
    );
  }
}
