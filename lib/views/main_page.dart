import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_storage/cubit/jake_bloc_cubit.dart';
import 'package:offline_storage/helper/permission.dart';
import 'package:offline_storage/utils/nothing.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    Permission().checkInternet().then((value) {
      if (value) {
        context.read<JakeBlocCubit>().getJake(1);
      } else {
        print("No Intenet Connection");
        context.read<JakeBlocCubit>().getJakeFromDb();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Page"),
      ),
      body: BlocBuilder<JakeBlocCubit, JakeBlocState>(
        builder: (context, state) {
          if (state is JakeBlocError) {
            return Text(state.error);
          }
          if (state is JakeBlocLoading || state is JakeBlocInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is JakeBlocCompleted) {
            if (state.jakeWharton.isEmpty) {
              return const Center(
                child: Text("No Data Found"),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.jakeWharton.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(state.jakeWharton[index].subscriptionUrl.toString())
                  ],
                );
              },
            );
          }
          return const Nothing();
        },
      ),
    );
  }
}
