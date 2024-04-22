import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_structure/features/home/bloc/get_post_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<GetPostCubit>().fetchPostData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<GetPostCubit, GetPostState>(
          builder: (context, state) {
            if (state is GetPostLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetPostLoaded) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.all(8),
                shrinkWrap: true,
                itemCount: state.post.length,
                itemBuilder: (context, index) {
                  if (state.post.isEmpty) {
                    return Center(
                      child: Text(
                        'No Data',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }
                  return ListTile(
                    title: Text(state.post[index].title),
                    subtitle: Text(state.post[index].body),
                  );
                },
              );
            } else if (state is GetPostError) {
              return Center(
                child: Text(
                  'Error',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
