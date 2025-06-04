import 'package:flutter/material.dart';
import 'package:project_ourecycle/widgets/transaksi_completed.dart';
import 'package:project_ourecycle/widgets/transaksi_in_progress.dart';

class TransaksiScreen extends StatefulWidget {
  const TransaksiScreen({super.key});

  @override
  State<TransaksiScreen> createState() => _TransaksiScreenState();
}

class _TransaksiScreenState extends State<TransaksiScreen> {
  // Menentukan tab yang aktif
  bool isInProgress = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Center(
                child: Text(
                  'Transaksi',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tombol In Progress
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isInProgress = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isInProgress ? Colors.red : Colors.grey,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'In Progress',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),

                const SizedBox(width: 20),

                // Tombol Completed
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isInProgress = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !isInProgress ? Colors.green : Colors.grey,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Completed',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Menampilkan konten berdasarkan tab aktif
            Expanded(
              child:
                  isInProgress ? TransaksiInProgress() : TransaksiCompleted(),
            ),
          ],
        ),
      ),
    );
  }
}
