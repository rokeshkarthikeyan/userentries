import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:user_entries/bloc/users_bloc.dart';
import 'package:user_entries/bloc/users_event.dart';
import 'package:user_entries/bloc/users_state.dart';
import 'package:user_entries/screens/user_details.dart';

class UserLists extends StatefulWidget {
  @override
  _UserListsState createState() => _UserListsState();
}

class _UserListsState extends State<UserLists> {
  final ScrollController _scrollController = ScrollController();
  final UserBloc _userBloc = UserBloc();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _userBloc.add(FetchUsers(1));
    _scrollController.addListener(loadMoreData);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _userBloc.close();
    super.dispose();
  }

  void loadMoreData() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (_userBloc.currentPage < 2) {
        _userBloc.add(FetchUsers(_userBloc.currentPage + 1));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users List'),
        elevation: 10,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: _userBloc,
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UsersLoaded) {
            return ListView.separated(
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 3,
                );
              },
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 6,
                      alignment: Alignment.center,
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UserDetails(index + 1)));
                        },
                        title: Text(state.users[index].firstName!),
                        subtitle: Text(state.users[index].email!),
                        trailing: CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              NetworkImage(state.users[index].avatar!),
                        ),
                        leading: Text(
                          state.users[index].id.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    if (index == state.users.length - 1 && state.isLoading)
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: SpinKitCircle(color: Colors.blue),
                      )
                  ],
                );
              },
              controller: _scrollController,
            );
          } else {
            return Center(child: Text('Failed to load users'));
          }
        },
      ),
    );
  }
}
