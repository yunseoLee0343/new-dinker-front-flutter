import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:new_dinker/app/bloc/app_bloc.dart';

import '../../navigate/bloc/navigate_bloc.dart';

class BrandPage extends StatefulWidget {
  @override
  State<BrandPage> createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  @override
  Widget build(BuildContext context) {
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);

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
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        onTap: (int index) {
          switch (index) {
            case 0:
              navigationBloc.add(NavigationEvent.home);
              selectedIndex = 0;
              break;
            case 1:
              navigationBloc.add(NavigationEvent.brands);
              selectedIndex = 1;
              break;
          }
        },
      ),

      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: MediaQuery.sizeOf(context).height/20,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Brands'),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Column(
                      children: <Widget>[
                        ListTile(
                          title: Text('Brand $index'),
                          onTap: () {
                            print('Brand $index');
                          },
                        ),
                        const Divider(),
                      ],
                    );
                  },
                  childCount: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}