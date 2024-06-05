#include <OneWire.h>
#include <DallasTemperature.h>
#include <DS18B20Events.h>

const int pressurePin = A1;   // Analog pin connected to pressure transducer
const int oneWireBus = 2;     // Pin where the DS18B20 is connected

OneWire oneWire(oneWireBus);
DallasTemperature sensors(&oneWire);

unsigned long startTime;

void setup() {
  Serial.begin(9600);
  sensors.begin();  // Initialize the temperature sensor
  startTime = millis(); // Record the start time
}

void loop() {
  delay(2000);

  unsigned long currentTime = millis();
  float timeInSeconds = (currentTime - startTime) / 1000.0; // Calculate time in seconds

  int sensorValue = analogRead(pressurePin); // Read sensor value

  float voltage = sensorValue * (5.0 / 1023.0);  // Convert to voltage
  // Assuming 0.5V = 0 PSI and 4.5V = 100 PSI
  float baselineVoltage = 0.45;  // Example value, adjust based on your sensor at zero pressure

  float pressure_psi = (voltage - baselineVoltage) * (100.0 / (4.5 - baselineVoltage)); // Pressure in PSI
  float pressure_pa = pressure_psi * 6894.76*1.79265433679; // Convert pressure to Pascal

  sensors.requestTemperatures();
  float temperatureC = sensors.getTempCByIndex(0); // Get temperature in Celsius

  // Print the data to the serial port
  Serial.print(timeInSeconds);
  Serial.print(",");
  Serial.print(pressure_pa);
  Serial.print(",");
  Serial.println(temperatureC);
  
  delay(100); // Wait for a while before next cycle
}
