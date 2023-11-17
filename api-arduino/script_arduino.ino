int switch_pin = 7;
int reg = 0;

void setup() {
  Serial.begin(9600);
  pinMode(switch_pin, INPUT);
}

void loop() {
  
  if(digitalRead(switch_pin) == LOW){
    if (reg == 0) {
      reg = 1;
      Serial.println(1);
    } 
  } else {
    reg = 0;
  }
  delay(800);
}