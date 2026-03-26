import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// ─── Models ────────────────────────────────────────────────
class College {
  final int id;
  final String name;
  final String code;
  final String shortName;
  final bool isActive;

  const College({
    required this.id,
    required this.name,
    required this.code,
    required this.shortName,
    this.isActive = true,
  });

  static List<College> get demoColleges => const [
        College(id: 1, name: 'College of Engineering', code: 'COE', shortName: 'Engineering'),
        College(id: 2, name: 'College of Medicine', code: 'COM', shortName: 'Medicine'),
        College(id: 3, name: 'College of Business', code: 'COB', shortName: 'Business'),
        College(id: 4, name: 'College of Law', code: 'COL', shortName: 'Law'),
        College(id: 5, name: 'College of Science', code: 'COS', shortName: 'Science'),
      ];
}

// ─── Events ────────────────────────────────────────────────
abstract class CollegeSelectorEvent extends Equatable {
  const CollegeSelectorEvent();
  @override
  List<Object?> get props => [];
}

class CollegeSelectorLoadRequested extends CollegeSelectorEvent {}

class CollegeSelectorChanged extends CollegeSelectorEvent {
  final int? collegeId; // null means "All Colleges"
  const CollegeSelectorChanged({this.collegeId});
  @override
  List<Object?> get props => [collegeId];
}

// ─── States ────────────────────────────────────────────────
class CollegeSelectorState extends Equatable {
  final List<College> colleges;
  final int? selectedCollegeId;
  final bool isLoading;

  const CollegeSelectorState({
    this.colleges = const [],
    this.selectedCollegeId,
    this.isLoading = false,
  });

  College? get selectedCollege {
    if (selectedCollegeId == null) return null;
    try {
      return colleges.firstWhere((c) => c.id == selectedCollegeId);
    } catch (_) {
      return null;
    }
  }

  String get displayName =>
      selectedCollege?.shortName ?? 'All Colleges';

  CollegeSelectorState copyWith({
    List<College>? colleges,
    int? Function()? selectedCollegeId,
    bool? isLoading,
  }) {
    return CollegeSelectorState(
      colleges: colleges ?? this.colleges,
      selectedCollegeId: selectedCollegeId != null
          ? selectedCollegeId()
          : this.selectedCollegeId,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [colleges, selectedCollegeId, isLoading];
}

// ─── Bloc ──────────────────────────────────────────────────
class CollegeSelectorBloc
    extends Bloc<CollegeSelectorEvent, CollegeSelectorState> {
  CollegeSelectorBloc() : super(const CollegeSelectorState()) {
    on<CollegeSelectorLoadRequested>(_onLoad);
    on<CollegeSelectorChanged>(_onChanged);
  }

  Future<void> _onLoad(
      CollegeSelectorLoadRequested event, Emitter<CollegeSelectorState> emit) async {
    emit(state.copyWith(isLoading: true));
    await Future.delayed(const Duration(milliseconds: 300));
    emit(state.copyWith(
      colleges: College.demoColleges,
      isLoading: false,
    ));
  }

  void _onChanged(
      CollegeSelectorChanged event, Emitter<CollegeSelectorState> emit) {
    emit(state.copyWith(
      selectedCollegeId: () => event.collegeId,
    ));
  }
}
