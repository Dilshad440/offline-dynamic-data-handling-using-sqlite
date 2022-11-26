import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_storage/constants/global_variable.dart';
import 'package:offline_storage/cubit/jake_bloc_cubit.dart';
import 'package:offline_storage/cubit/jake_bloc_state.dart';
import 'package:offline_storage/helper/error_handling.dart';
import 'package:offline_storage/helper/permission.dart';
import 'package:offline_storage/utils/nothing.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _scrollController = ScrollController();
  @override
  void initState() {
    Permission().checkInternet().then((value) {
      if (value) {
        context.read<JakeBlocCubit>().getJake();
      } else {
        context.read<JakeBlocCubit>().getJakeFromDb();
      }
    });
    _scrollController.addListener(() {
      if (_scrollController.position.extentAfter <= 0) {
        context.read<JakeBlocCubit>().getMoreJake();
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
          if (state.networkState == NetworkState.failed) {
            final error = ErrorHandling.getErrorMessage(state.errorResponse!);
            return Center(
              child: Text(error),
            );
          }
          if (state.networkState == NetworkState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.networkState == NetworkState.loaded) {
            return ListView.builder(
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: state.responseModel?.body.jake.length,
              itemBuilder: (context, index) {
                final jake = state.responseModel?.body.jake ?? [];
                if (index == jake.length - 1 && state.isLoadingMore) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  children: [
                    Text(jake[index].subscriptionUrl.toString()),
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
