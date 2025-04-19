# 🚀 Radar System

An educational radar-like system built with Arduino UNO, an HC-SR04 ultrasonic sensor, and a servo motor. The system scans the surrounding environment by rotating the ultrasonic sensor and visualizes the detected objects in real-time using Processing.

---

## 📌 Description

This project simulates a simple 2D radar system. The HC-SR04 ultrasonic sensor is mounted on a servo motor, which rotates to scan a defined angular field. The measured distances are sent from the Arduino to the PC over a serial connection. A custom Processing sketch receives and visualizes the data in real-time, displaying obstacles as points on a radar-like interface.

---

## ⚙️ System Architecture

### 🔧 Hardware Components
- Arduino UNO
- HC-SR04 Ultrasonic Sensor
- SG90 Servo Motor
- Breadboard and jumper wires
- USB cable for Arduino-PC communication

### 💻 Software Tools
- PlatformIO in Visual Studio Code (for writing and uploading firmware)
- Processing (for visualizing distance measurements)
- Serial communication (between Arduino and PC)

**Workflow:**
1. Servo motor rotates from 0° to 180°.
2. At each step, the ultrasonic sensor measures distance.
3. Data is sent over serial to Processing.
4. Processing plots the data in polar coordinates, simulating a radar display.

## 🧪 Example Use

When powered and running, the servo will sweep from 0° to 180° and back. Obstacles will appear as dots on the radar interface in Processing. You can test it by placing objects at various distances in front of the sensor.

---

## ✅ TODO

- [ ] Add smoothing/filtering to distance readings
- [ ] Expand scan to 360° using a continuous rotation servo
- [ ] Add sound or alert for close objects
- [ ] Log distance data to file
- [ ] Improve UI in Processing (colors, scale, labels)

---

## 📬 Contact

Created by [Luka Radović](https://github.com/your-github-username)  
Feel free to reach out or contribute to the project!

---

## 📝 License

This project is open-source and available under the [MIT License](LICENSE).

