
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../home/data/models/finance_item_model.dart';
import '../../../../data/repos/analytic_repo.dart';
import 'manage_line_state_state.dart';

class ManageLineChartCubit extends Cubit<ManageLineChartState> {
  ManageLineChartCubit({required this.analyticRepo})
    : super(ManageLineChartInitialState());
  final AnalyticRepo analyticRepo;
  List<FlSpot> calculateCumulativeBalance(List<FinanceItemModel> items) {
    return analyticRepo.calculateCumulativeBalance(items);
  }
}

