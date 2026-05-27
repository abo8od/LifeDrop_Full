import 'package:donor_app/core/mixins/snack_bar_mixin.dart';
import 'package:donor_app/features/donation_history/presentation/logic/donation_history_cubit.dart';
import 'package:donor_app/features/donation_history/presentation/screens/donation_history_screen.dart';
import 'package:donor_app/features/home/presentation/screens/home_screen.dart';
import 'package:donor_app/features/main_navigation/widgets/custom_navigation_bar.dart';
import 'package:donor_app/features/home/presentation/logic/home_cubit.dart';
import 'package:donor_app/features/profile/presentation/logic/cooldown/cooldown_cubit.dart';
import 'package:donor_app/features/profile/presentation/logic/profile/profile_cubit.dart';
import 'package:donor_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:donor_app/features/realtime/domain/entities/realtime_event.dart';
import 'package:donor_app/features/realtime/presentation/logic/realtime_cubit.dart';
import 'package:donor_app/features/requests/presentation/logic/active_donation/active_donation_cubit.dart';
import 'package:donor_app/features/requests/presentation/screens/active_donation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen>
    with SnackBarMixin {
  final indexNotifier = ValueNotifier(0);
  final Set<int> _loadedIndexes = {0};
  late final RealtimeCubit _realtimeCubit;

  final List<Widget> screens = [
    const HomeScreen(),
    const ActiveDonationScreen(),
    const DonationHistoryScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _realtimeCubit = context.read<RealtimeCubit>();
    _realtimeCubit.connect();
  }

  @override
  void dispose() {
    indexNotifier.dispose();
    _realtimeCubit.disconnect();
    super.dispose();
  }

  void _handleNavigationTap(int index) {
    if (index == indexNotifier.value) return;

    indexNotifier.value = index;
    if (_loadedIndexes.contains(index)) return;
    _loadedIndexes.add(index);

    switch (index) {
      case 1:
        context.read<ActiveDonationCubit>().getCurrentActiveDonation();
        break;
      case 2:
        context.read<DonationHistoryCubit>().loadHistory();
        break;
      case 3:
        context.read<ProfileCubit>().getUserProfile();
        context.read<CooldownCubit>().getCooldownStatus();
        break;
    }
  }

  void _handleRealtimeEvent(RealtimeEvent? event) {
    if (event == null) return;

    switch (event) {
      case NewDonationRequestEvent():
        context.read<HomeCubit>().addRealtimeDonationRequest(event);
        _showMessage(event.title, event.body);
        break;
      case ActiveDonationUpdatedEvent():
        _handleActiveDonationUpdated(event);
        _showMessage(null, event.message);
        break;
      case RealtimeNotificationEvent():
        _showMessage(event.title, event.body);
        break;
      case ProfileUpdatedEvent():
        break;
      case RealtimeReconnectedEvent():
        context.read<HomeCubit>().loadHome();
        context.read<ActiveDonationCubit>().getCurrentActiveDonation();
        if (_loadedIndexes.contains(3)) {
          context.read<ProfileCubit>().getUserProfile();
          context.read<CooldownCubit>().getCooldownStatus();
        }
        break;
    }
  }

  void _handleActiveDonationUpdated(ActiveDonationUpdatedEvent event) {
    final activeDonationCubit = context.read<ActiveDonationCubit>();

    switch (event.status) {
      case 'Accepted':
        activeDonationCubit.getCurrentActiveDonation();
        break;
      case 'Fulfilled':
        _refreshAfterDonationFulfilled(activeDonationCubit);
        break;
      default:
        activeDonationCubit.applyRealtimeUpdate(event);
        break;
    }
  }

  void _refreshAfterDonationFulfilled(ActiveDonationCubit activeDonationCubit) {
    final hospitalName = activeDonationCubit.currentHospitalName;

    activeDonationCubit.getCurrentActiveDonation();
    context.read<HomeCubit>().refreshAfterDonationFulfilled(
      hospitalName: hospitalName,
    );
  }

  void _showMessage(String? title, String body) {
    final text = title == null || title.isEmpty ? body : '$title\n$body';
    if (text.trim().isEmpty) return;

    showInfoSnackBar(context, message: text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RealtimeCubit, RealtimeState>(
      listener: (context, state) => _handleRealtimeEvent(state.event),
      child: ValueListenableBuilder(
        valueListenable: indexNotifier,
        builder: (context, currentIndex, child) {
          return Scaffold(
            bottomNavigationBar: CustomNavigationBar(
              currentIndex: currentIndex,
              onTap: _handleNavigationTap,
            ),
            body: screens[currentIndex],
          );
        },
      ),
    );
  }
}
