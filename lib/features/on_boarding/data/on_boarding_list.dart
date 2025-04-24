import 'package:finance_flutter_app/core/helper/app_images.dart';
import 'package:finance_flutter_app/generated/l10n.dart';

import 'models/on_boarding_model.dart';

final List<OnBoardingModel> onboardingList = [
  OnBoardingModel(
    title: S.current.onBoarding_title_1,
    subTitle: S.current.onBoarding_subTitle_1,
    image: AppImages.splashFinance1,
  ),
  OnBoardingModel(
    title: S.current.onBoarding_title_2,
    subTitle: S.current.onBoarding_subTitle_2,
    image: AppImages.splashFinance2,
  ),
  OnBoardingModel(
    title: S.current.onBoarding_title_3,
    subTitle: S.current.onBoarding_subTitle_3,
    image: AppImages.splashFinance3,
  ),
];
