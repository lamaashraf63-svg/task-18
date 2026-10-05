import 'package:flutter/material.dart';
import 'add_task_screen.dart';
import 'task_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<TaskModel> _tasks = [
    TaskModel(
      id: '1',
      title: 'Flutter UI',
      description: 'Build Register Screen',
      status: 'Pending',
      color: const Color(0xFF4C6FFF),
    ),
    TaskModel(
      id: '2',
      title: 'Workout',
      description: 'Gym at 6 PM',
      status: 'Done',
      color: const Color(0xFF2DDA93),
    ),
    TaskModel(
      id: '3',
      title: 'Meeting',
      description: 'Team Sync',
      status: 'In Progress',
      color: const Color(0xFFFF9F43),
    ),
    TaskModel(
      id: '4',
      title: 'Read Book',
      description: 'Atomic Habits',
      status: 'Pending',
      color: const Color(0xFF8C52FF),
    ),
  ];

  void _addTask(TaskModel newTask) {
    setState(() {
      _tasks.add(newTask);
    });
  }

  int get _doneCount => _tasks.where((t) => t.status == 'Done').length;
  int get _pendingCount => _tasks.where((t) => t.status == 'Pending').length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: const Color(0xFF3B4371),
                    child: const Icon(Icons.person, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Good Morning ',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const Text('👋', style: TextStyle(fontSize: 12)),
                        ],
                      ),
                      const Text(
                        'Ahmed',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.notifications_none, color: Colors.black87),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B4371),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatItem(count: _tasks.length.toString(), label: 'Tasks'),
                    const _VerticalDivider(),
                    _StatItem(count: _doneCount.toString(), label: 'Done'),
                    const _VerticalDivider(),
                    _StatItem(count: _pendingCount.toString(), label: 'Pending'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Today's Tasks",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    final task = _tasks[index];
                    return TaskCard(
                      title: task.title,
                      subtitle: task.description,
                      status: task.status,
                      statusColor: task.color,
                      indicatorColor: task.color,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final newTask = await Navigator.push<TaskModel>(
            context,
            MaterialPageRoute(
              builder: (context) => const AddTaskScreen(),
            ),
          );
          if (newTask != null) {
            _addTask(newTask);
          }
        },
        backgroundColor: const Color(0xFFE2E7F4),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        icon: const Icon(Icons.add, color: Color(0xFF3B4371), size: 20),
        label: const Text(
          'Task',
          style: TextStyle(
            color: Color(0xFF3B4371),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String count;
  final String label;

  const _StatItem({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 1,
      color: Colors.white.withOpacity(0.25),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String status;
  final Color statusColor;
  final Color indicatorColor;

  const TaskCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.statusColor,
    required this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 42,
            decoration: BoxDecoration(
              color: indicatorColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: statusColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.chevron_right, size: 20, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}