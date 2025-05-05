import 'package:finance_flutter_app/features/analytic/data/repos/analytic_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../home/data/models/finance_item_model.dart';
import 'manage_bar_chart_state.dart';

class ManageBarChartCubit extends Cubit<ManageBarChartState> {
  ManageBarChartCubit({required this.analyticRepo})
    : super(ManageBarChartInitialState());
  final AnalyticRepo analyticRepo;
  Map<int, Map<String, double>> getGroupByMonth(List<FinanceItemModel> items) {
    return analyticRepo.getGroupByMonth(items);
  }
}