import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_dinker/app/app.dart';
import 'package:new_dinker/home/home.dart';

import 'package:new_dinker/fetch/view/brand.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/logo.png', width: MediaQuery.sizeOf(context).width/3,),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                context.read<AppBloc>().add(const AppLogoutRequested());
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: 'Brands',
            ),
          ],
          selectedItemColor: Colors.amber[800],
          onTap: (int index) {
            switch(index){
              case 0:
                print(context.hashCode);
                GoRouter.of(context).go('/home');
                //context.goNamed('/home');
                break;
              case 1:
                print(context.hashCode);
                GoRouter.of(context).go('/brands');
                //context.goNamed('/brands');
                break;
            }
          },
        ),

        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[

              //MiniSearchBar(),

              SliverPadding(
                padding: EdgeInsets.all(10),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Text('New Events', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.sizeOf(context).height/50,),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height/5,
                          aspectRatio: 16 / 9,
                          viewportFraction: 0.8,
                          autoPlay: true,
                          enlargeCenterPage: true,
                        ),
                        items: [1,2,3,4,5].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                  ),
                                  child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              SliverPadding(
                padding: EdgeInsets.all(10),
                sliver: SliverToBoxAdapter(
                    key: UniqueKey(),
                    child: SizedBox(height: MediaQuery.sizeOf(context).height/30,)
                ),
              ),

              SliverPadding(
                padding: EdgeInsets.all(10),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Text('New Products', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                      SizedBox(height: MediaQuery.sizeOf(context).height/50,),
                      Container(
                        key: UniqueKey(),
                        height: MediaQuery.sizeOf(context).height,
                        child: ListView.builder(
                          //scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 100.0,
                                child: Card(
                                  child: Text('data'),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}