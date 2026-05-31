import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:klyr/data/model/activity_items.dart';
import 'package:klyr/data/model/summary_row.dart';
import 'package:klyr/presentation/auth/bloc/authbloc.dart';
import 'package:klyr/presentation/auth/bloc/authevent.dart';
import 'package:klyr/presentation/home/bloc/home_bloc.dart';
import 'package:klyr/presentation/home/bloc/home_event.dart';
import 'package:klyr/presentation/home/bloc/home_state.dart';
import 'package:klyr/presentation/home/pages/groupexppage.dart';
import 'package:klyr/presentation/home/pages/personalexppage.dart';
import 'package:klyr/presentation/home/widgets/home_header.dart';
import 'package:klyr/presentation/home/widgets/segment_toggle.dart';
import 'package:klyr/presentation/home/widgets/summary_card.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  static const _accent = Color(0xFFE8630A);
  static const _owedGreen = Color(0xFF2E9E5B);
  static const _oweRed = Color(0xFFE05A3A);

  late final PageController _pageController;
  int _segmentIndex = 0;

  static var _groupActivities = [
    ActivityItem(
      id: 1,
      title: 'Dinner at Agashiye',
      date: 'May 21',
      amount: '₹1,800',
      isHighlighted: true,
    ),
    ActivityItem(
      id: 2,
      title: 'Cab to airport',
      date: 'May 19',
      amount: '₹420',
    ),
    ActivityItem(id: 3, title: 'Movie tickets', date: 'May 17', amount: '₹630'),
    ActivityItem(
      id: 4,
      title: 'Groceries split',
      date: 'May 15',
      amount: '₹290',
    ),
  ];

  static var _personalActivities = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _segmentIndex);
    context.read<HomeBloc>().add(GetHomeEvent());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onSegmentChanged(int index) {
    if (_segmentIndex == index) return;
    setState(() => _segmentIndex = index);
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOutCubic,
      );
    }
  }

  void _onPageChanged(int index) {
    if (_segmentIndex == index) return;
    setState(() => _segmentIndex = index);
  }

  Future<void> _onRefresh() async {
    context.read<HomeBloc>().add(GetHomeEvent());
    await context
        .read<HomeBloc>()
        .stream
        .firstWhere(
          (state) => state is HomeSuccessState || state is HomeFailureState,
        )
        .timeout(
          const Duration(seconds: 10),
          onTimeout: () => HomeFailureState(message: "Request Timed out"),
        );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final pageBg =
        isDark
            ? Theme.of(context).scaffoldBackgroundColor
            : const Color(0xFFF4F4F4);

    return Scaffold(
      backgroundColor: pageBg,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_segmentIndex == 0) {
            context.pushNamed('createpersonalexpensepage');
          } else {
            context.pushNamed('createpersonalexpensepage');
          }
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: const HomeHeader(firstLetter: "A"),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: RefreshIndicator(
                color: _accent,
                onRefresh: _onRefresh,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  children: [
                    const SummaryCard(
                      rows: [
                        SummaryRow(
                          label: 'total expense',
                          value: '₹4,850',
                          valueColor: _accent,
                        ),
                        SummaryRow(
                          label: 'owed to you',
                          value: '₹1,200',
                          valueColor: _owedGreen,
                        ),
                        SummaryRow(
                          label: 'you owe',
                          value: '₹650',
                          valueColor: _oweRed,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    SegmentToggle(
                      labels: const ['Group', 'Personal'],
                      selectedIndex: _segmentIndex,
                      onChanged: _onSegmentChanged,
                    ),
                    const SizedBox(height: 14),
                    BlocConsumer<HomeBloc, HomeState>(
                      listener: (context, state) {
                        if (state is HomeSuccessState) {
                          setState(() {
                            _personalActivities = state.activityItems;
                            _groupActivities = state.activityItems;
                          });
                        } else if (state is HomeUnauthState) {
                          context.read<Authbloc>().add(LogoutEvent());
                          context.pushReplacementNamed("authpage");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is HomeLoadingState) {
                          return SizedBox(
                            height: 320,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        if (state is HomeFailureState) {
                          return SizedBox(
                            height: 320,
                            child: Center(child: Text(state.message)),
                          );
                        }
                        if (state is HomeSuccessState &&
                            state.activityItems.isEmpty) {
                          return SizedBox(
                            height: 320,
                            child: Center(child: Text("No Expense Added Yet")),
                          );
                        }
                        return SizedBox(
                          height: 320,
                          child: PageView.builder(
                            controller: _pageController,
                            onPageChanged: _onPageChanged,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              final items =
                                  index == 0
                                      ? _groupActivities
                                      : _personalActivities;
                              if (index == 0) {
                                return Groupexppage(items: []);
                              } else {
                                return Personalexppage(items: items);
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
