import 'dart:developer';
import 'package:finance_flutter_app/features/home/presentation/manager/cubits/manage_finance_cubit/manage_finance_cubit.dart';
import 'package:finance_flutter_app/features/home/presentation/manager/cubits/manage_finance_cubit/manage_finance_state.dart';
import 'package:finance_flutter_app/features/home/presentation/views/widgets/finance_list_view_builder.dart';
import 'package:finance_flutter_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../data/models/finance_item_model.dart';

class AllActivitiesView extends StatefulWidget {
  const AllActivitiesView({super.key});
  static const String routeName = 'all-activities-view';

  @override
  State<AllActivitiesView> createState() => _AllActivitiesViewState();
}

class _AllActivitiesViewState extends State<AllActivitiesView> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;
  List<FinanceItemModel> financeItems = [];
  void getFinancesByDay(DateTime day) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<ManageFinanceCubit>(context).getFinancesByDay(day);
    });
  }

  @override
  void initState() {
    super.initState();
    getFinancesByDay(_selectedDay);
  }

  Future<void> _onRefresh() async {
    BlocProvider.of<ManageFinanceCubit>(context).getFinancesByDay(_selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).all_activities)),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              TableCalendar(
                firstDay: DateTime.utc(2000, 1, 1),
                lastDay: DateTime.utc(2100, 12, 31),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  BlocProvider.of<ManageFinanceCubit>(
                    context,
                  ).getFinancesByDay(_selectedDay);
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                daysOfWeekHeight: 30,
              ),
              BlocConsumer<ManageFinanceCubit, ManageFinanceState>(
                listener: (context, state) {
                  if (state is GetFinancesByDayFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(S.of(context).somethingWentWrong)),
                    );
                    log(state.failureMessage.toString());
                  } else if (state is GetFinancesByDaySuccessState) {
                    financeItems = state.financeItems;
                  } else if (state is DeleteFinanceFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(S.of(context).somethingWentWrong)),
                    );
                    log(state.failureMessage.toString());
                  } else if (state is DeleteFinanceSuccessState) {}
                },
                builder: (context, state) {
                  return FinanceListViewBuilder(financeItems: financeItems);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
