import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../home/data/models/finance_item_model.dart';
import '../../../../data/repos/analytic_repo.dart';
import 'manage_pie_chart_state.dart';

class ManagePieChartCubit extends Cubit<ManagePieChartState> {
  ManagePieChartCubit({required this.analyticRepo})
    : super(ManagePieChartInitialState());
  final AnalyticRepo analyticRepo;
  Map<int, double> getGroupByCategory(List<FinanceItemModel> items) {
    return analyticRepo.getGroupByCategory(items);
  }
}
