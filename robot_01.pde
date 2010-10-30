
#define RIGHT 1
#define LEFT -1

int lastBest = RIGHT;
int lastBestDist = 0;

void forward()
{
  digitalWrite(2, LOW);
  digitalWrite(3, HIGH);
  //analogWrite(3, 200); // Correct the difference in speed between the two motors ...
  digitalWrite(4, LOW);
  digitalWrite(5, HIGH);
}

void backward()
{
  digitalWrite(2, HIGH);
  digitalWrite(3, LOW);
  digitalWrite(4, HIGH);
  digitalWrite(5, LOW);
}

void right()
{
  digitalWrite(2, LOW);
  digitalWrite(3, HIGH);
  digitalWrite(4, HIGH);
  digitalWrite(5, LOW);
}

void left()
{
  digitalWrite(2, HIGH);
  digitalWrite(3, LOW);
  digitalWrite(4, LOW);
  digitalWrite(5, HIGH);
}

void stop()
{
  digitalWrite(2, LOW);
  digitalWrite(3, LOW);
  digitalWrite(4, LOW);
  digitalWrite(5, LOW);
}

void setup()
{
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(13, OUTPUT);
  
  //Serial.begin(115200);
}

void loop()
{
  delay(100);
  
  int distance = analogRead(0);
  //Serial.println(distance, DEC);
  
  if( distance < 15 ) 
  {
    stop();
    digitalWrite(13, HIGH);
    
    backward();
    delay(500);
    
    // Take a new reading after backing up
    distance = analogRead(0);
    
    if(lastBest == RIGHT)
    {
      // Check on the right first
      right();
    }
    else
    {
      // Check on the left first
      left();
    }
    
    // Turn ...
    delay(500);
    stop();

    // Check if it is better that way
    lastBestDist = analogRead(0);
    if( lastBestDist > distance + 2 )
    {
      // Go that way ...
      if(lastBest == RIGHT)  
      {
        //right();
        lastBest = RIGHT;
      }
      else
      {
        //left();
        lastBest = LEFT;
      }
    }
    else
    {
      // Check on the other side ...
      if(lastBest == RIGHT)
      {
        // Check on the right first
        left();        
      }
      else
      {
        // Check on the left first
        right();
      }
    
      // Turn ...
      delay(1000);
      stop();
      
      if( analogRead(0) > lastBestDist )
      {
        // Go that way ...
        if(lastBest == RIGHT)  
        {
          //left();
          lastBest = LEFT;
        }
        else
        {
          //right();
          lastBest = RIGHT;
        }
      }
      else
      {
        // Go the other way ...
        if(lastBest == RIGHT)  
        {
          right();
          lastBest = LEFT;
          delay(1000);
        }
        else
        {
          left();
          lastBest = RIGHT;
          delay(1000);
        }
      }
    }
  }
  else
  {
    digitalWrite(13, LOW);
    forward();
  }
}

