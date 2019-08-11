import 'package:flutter/material.dart';
import 'package:off_the_map/controllers/action_status_controller.dart';
import 'package:provider/provider.dart';

/// consumes ActionStatusController
/// Used to show whether an action was successful or not
class ActionStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ActionStatusController actionStatusController =
        Provider.of<ActionStatusController>(context);

    return Visibility(
      visible: actionStatusController.visible,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: actionStatusController.backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: actionStatusController.currentIcon,
                ),
                Flexible(
                  child: Text(
                    actionStatusController.currentMessage,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
