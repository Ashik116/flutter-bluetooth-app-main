import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_bluetooth_app/controllers/bluetooth_controller.dart';
import 'package:get/get.dart';

class DeviceShow extends StatelessWidget {
  const DeviceShow({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BluetoothController>(
          init: BluetoothController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20 * 3),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.scanDevices();
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(350, 55),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                      child: const Text(
                        'Scan',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 400,
                          width: double.infinity,
                          child: StreamBuilder<List<ScanResult>>(
                            stream: controller.scanResults,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    final device = snapshot.data![index].device;
                                    return Card(
                                      elevation: 5,
                                      child: ListTile(
                                        onTap: () {},
                                        title: Text(device.type.name.toString()),
                                        subtitle: Text(device.id.id),
                                        trailing: TextButton(
                                          onPressed: () {
                                            controller.connectToDevice(device);
                                          },
                                          child: Text(BluetoothConnectionState.connected==device.state?"Connected":"Connect"),
                                          // child: Text(BluetoothDeviceState.connected ==
                                          //     device.state
                                          //     ? 'Connected'
                                          //     : 'Connect'),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return const Center(
                                  child: Text('No devices found'),
                                );
                              }
                            },
                          ),
                        ),
                        TextButton(onPressed: (){
                          controller.scanDevices();
                        }, child: Text("Refresh"))
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}