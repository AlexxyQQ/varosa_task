import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/abstract/presentation/bloc/crud/crud.bloc.dart';
import '../../../../../core/common/presentation/views/widgets/app_text.widget.dart';
import '../../../data/models/item.model.dart';
import '../../bloc/item.bloc.dart';
import '../widgets/create_item_bottom_sheet.widget.dart';
import '../widgets/item_card.widget.dart';

@RoutePage(name: 'TodoPageRoute')
class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppText('Todos'),
        actions: [
          IconButton(
            onPressed: () async =>
                await CreateItemBottomSheet.show(context: context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const TodoBody(),
    );
  }
}

class TodoBody extends StatelessWidget {
  const TodoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemBloc, CrudState<ItemModel>>(
      listener: (context, state) {
        if (state.error != null && !state.isLoading) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error!.message)));
        }
        if (state.successMessage != null && !state.isLoading) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.successMessage!)));
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.entities.isEmpty) {
          return const Center(child: Text('No data'));
        }
        return RefreshIndicator(
          onRefresh: () async {
            context.read<ItemBloc>().add(GetAllEntitiesEvent());
          },
          child: ListView.builder(
            itemCount: state.entities.length,
            itemBuilder: (context, index) {
              final ItemModel item = state.entities[index];
              return ItemCardWidget(data: item);
            },
          ),
        );
      },
    );
  }
}
