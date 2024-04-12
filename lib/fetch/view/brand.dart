import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:new_dinker/app/bloc/app_bloc.dart';

import '../../navigate/bloc/navigate_bloc.dart';
import '../bloc/fetch_bloc.dart';
import '../bloc/fetch_event.dart';
import '../bloc/fetch_state.dart';

class BrandPage extends StatefulWidget {
  @override
  State<BrandPage> createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  @override
  void initState() {
    super.initState();
    final _fetchBloc = BlocProvider.of<FetchBloc>(context); // Initialize FetchBloc
    _fetchBloc.add(FetchEvent.loading); // Dispatch FetchLoading event
  }

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
                title: Text('Brands', style: TextStyle(color: Colors.black),),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.all(8.0),
              sliver: BlocBuilder<FetchBloc, FetchState>(
                  builder: (context, state) {
                    if (state is FetchLoading) {
                      return SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                              return ListTile(
                                title: Text(state.brands[index]),
                                onTap: () {
                                  print('Brand ${state.brands[index]}');
                                },
                              );
                            },
                            childCount: state.brands.length,
                          ),
                      );
                    }
                    else if (state is FetchError) {
                      return SliverToBoxAdapter(
                        key: UniqueKey(),
                        child: Center(
                          child: Text('Error: ${state.error}'),
                        ),
                      );
                    } else {
                      return SliverToBoxAdapter(
                          key: UniqueKey(),
                          child: CircularProgressIndicator()
                      );
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}