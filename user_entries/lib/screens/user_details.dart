import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_entries/bloc/users_bloc.dart';
import 'package:user_entries/bloc/users_event.dart';
import 'package:user_entries/bloc/users_state.dart';

class UserDetails extends StatefulWidget {
  const UserDetails(this.index, {super.key});
  final int index;

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final UserBloc _userBloc = UserBloc();
  @override
  void initState() {
    _userBloc.add(FetchUser(widget.index));
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
    super.initState();
  }

  List<Color> colors = [
    Colors.blue.shade400,
    Colors.blue.shade200,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details"),
        elevation: 10,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: _userBloc,
        builder: (context, state) {
          if (state is UserLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is UserDetailsLoaded) {
            return Center(
              child: ScaleTransition(
                scale: _animation,
                child: AnimatedContainer(
                  height: 300,
                  duration: Duration(seconds: 3),
                  curve: Curves.elasticInOut,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: colors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 0.5],
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(state.user.avatar!),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            "Name : ",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Text(state.user.firstName!,
                              style: TextStyle(fontSize: 20)),
                          SizedBox(
                            width: 15,
                          ),
                          Text(state.user.lastName!,
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 40,
                          ),
                          Text("Email : ", style: TextStyle(fontSize: 20)),
                          SizedBox(
                            width: 40,
                          ),
                          Text(state.user.email!,
                              style: TextStyle(fontSize: 20)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 40,
                          ),
                          Text("Id : ", style: TextStyle(fontSize: 20)),
                          SizedBox(
                            width: 80,
                          ),
                          Text(state.user.id.toString(),
                              style: TextStyle(fontSize: 20)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(child: Text('Failed to load users'));
          }
        },
      ),
    );
  }
}
