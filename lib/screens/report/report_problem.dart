import 'package:aqua_care/screens/report/widgets/report_input_fields.dart';
import 'package:flutter/material.dart';

class ReportProblem extends StatefulWidget {
  const ReportProblem({super.key});

  @override
  State<ReportProblem> createState() => _ReportState();
}

class _ReportState extends State<ReportProblem>{

  final TextEditingController nameController = TextEditingController();
  final TextEditingController issueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.9,
              width: double.infinity,
              child: _buildInputFields(),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildInputFields(){
    return ReportInputFields(
        nameController: nameController,
        issueController: issueController,
    );
  }

}
