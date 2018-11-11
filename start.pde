int[] x1 = {320, 335, 350, 360, 372, 378, 380, 378, 372, 360, 350, 335, 320, 305, 290, 280, 272, 262, 260, 262, 268, 280, 290, 305};
int[] y1 = {180, 182, 190, 200, 215, 228, 240, 252, 270, 280, 290, 298, 300, 298, 290, 280, 270, 256, 240, 228, 215, 200, 190, 182};

int[] x2 = {320, 427, 534, 640, 640, 640, 640, 640, 640, 640, 534, 427, 320, 214, 107, 0, 0, 0, 0, 0, 0, 0, 107, 214};
int[] y2 = {0, 0, 0, 0, 80, 160, 240, 320, 400, 480, 480, 480, 480, 480, 480, 480, 400, 320, 240, 160, 80, 0, 0, 0};

float growingIndex = 0;
float contractIndex = 0;

int startTime = 0;
int growTime = 4000;//1s
boolean isPressed = false;
float newGrowingIndex = 10;
float topOfLineX = 0;
float topOfLineY = 0;
float ellipseRandomisedPosX = 0;
float ellipseRandomisedPosY = 0;

ColourGenerator colour = new ColourGenerator();


void setup()
{
    size(640, 480);
    startTime = millis();
}

void draw()
{
    background(0);
    strokeCap(ROUND);
    strokeWeight(3.0);
    stroke(0, 98, 255);
    
    if(mousePressed == true) {
        growingIndex = (float)(millis()-startTime)/growTime;
    } else {
        contractIndex = newGrowingIndex + (float)(millis() - startTime)/growTime;
    }
    // print(" Increase:", growingIndex);
    // print(" Decrease:", contractIndex, "\n");
        
    if(mousePressed == true) {
        if(mouseX > 260 && mouseX < 380 && mouseY > 180 && mouseY < 300 ) {
            if(contractIndex > 1 && isPressed == false) {
                startTime = millis();
                // print("1st Print **********************************************");
            }
            if(contractIndex > 0 && contractIndex < 1 && isPressed == false) {
                startTime = millis();
                // print("##########################################");
            }
            newGrowingIndex = 10;
            if(growingIndex < 1 && isPressed == true) {
                colour.update();
                fill(colour.R, colour.G, colour.B);
                stroke(colour.R, colour.G, colour.B);
                for(int i = 0; i < 24; i++) {

                    growingIndex = random(growingIndex - 0.005, growingIndex + 0.01);
                    topOfLineX = (1-growingIndex)*x1[i] + growingIndex*x2[i];
                    topOfLineY = (1-growingIndex)*y1[i] + growingIndex*y2[i];            
                    ellipseRandomisedPosX = random(topOfLineX - 10, topOfLineX + 10);
                    ellipseRandomisedPosY = random(topOfLineY - 10, topOfLineY + 10);
                    print(topOfLineX, topOfLineY, ellipseRandomisedPosX, ellipseRandomisedPosY, "\n");
                    line(x1[i], y1[i], (int)(ellipseRandomisedPosX), (int)(ellipseRandomisedPosY));
                    ellipse((int)(ellipseRandomisedPosX), (int)(ellipseRandomisedPosY), 20, 20);
                }
            } else {
                // startTime = millis();
                // print("2nd Print /////////////////////////////////////////////////");
                // Implement continuation after reaching max length
            }
            isPressed = true;
        }        
    } else {
        if(isPressed == true) {
            newGrowingIndex = 1 - growingIndex;
            startTime = millis();
            // print("3rd Print ###############################################");
        }
        isPressed = false;
        // startTime = millis();
        if(contractIndex < 1 && contractIndex > 0) {
            for(int i = 0; i < 24; i++) {
                topOfLineX = (int)( (1-contractIndex)*x2[i] + contractIndex*x1[i] );
                topOfLineY = (int)( (1-contractIndex)*y2[i] + contractIndex*y1[i] );
                line(x1[i], y1[i], topOfLineX, topOfLineY);
                ellipse(topOfLineX, topOfLineY, 20, 20);

            }
        }
    }
}