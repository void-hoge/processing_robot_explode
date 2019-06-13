float backgroundR = random(0, 255);
float backgroundG = random(0, 255);
float backgroundB = random(0, 255);

RobotExplode hoge, poyo;

void setup(){
    // randomSeed(2);
    size(800, 500);
    frameRate(60);
    strokeWeight(2);                //line thickness
    ellipseMode(RADIUS);            //ellipce(x, y, horizontalRadius, verticalRadius)radius:hankei
    hoge = new RobotExplode(400, 500, 150, 95);
    poyo = new RobotExplode(120, 420, 110, 140);
}

int framecount = 0;
int i = 15;
int j = 15;

void draw(){
    background(backgroundR, backgroundG, backgroundB);//(0,255,255);          //background color(light blue)

    poyo.display();
    hoge.display();
    if (framecount > 240){
        if (framecount < 480){
            if (i <= 0){
                hoge.colorrandomize();
                i = j;
                j--;
            }
            hoge.easing();
            hoge.ease*=0.99;
        }else{
            hoge.explode();
        }
    }else{
        hoge.easing();
    }
    i--;
    framecount++;
}

class coordinate{
    float x, y;
    float rotaterad;
    coordinate(){
        x = 0;
        y = 0;
        rotaterad = 0;
    }

    coordinate(float ax, float ay){
        x = ax;
        y = ay;
    }
}

class RobotExplode{
    float x, y, ny;
    int bodyHeight, neckHeight;
    int bodyWidth = 90;
    int headRadius = 45;
    float explodeparam = 0.05;
    float kakudo = 0;
    float kakudoparam = 0.05;
    float ease = 0.04;

    //initial coordinate
    coordinate neck1s, neck1g, neck2s, neck2g, neck3s, neck3g;
    coordinate neck1center, neck2center, neck3center;
    coordinate antenna1s, antenna1g, antenna2s, antenna2g, antenna3s, antenna3g;
    coordinate antenna1center, antenna2center, antenna3center;
    coordinate antigravity;
    coordinate body, bodycenter;
    coordinate stripe, stripecenter;
    coordinate head;
    coordinate bigeye, pupil;
    coordinate smalleye1, smalleye2, smalleye3;

    //explode targets coordinate
    coordinate neck1st, neck1gt, neck2st, neck2gt, neck3st, neck3gt;
    coordinate antenna1st, antenna1gt, antenna2st, antenna2gt, antenna3st, antenna3gt;
    coordinate antigravityt;
    coordinate bodyt;
    coordinate stripet;
    coordinate headt;
    coordinate bigeyet, pupilt;
    coordinate smalleye1t, smalleye2t, smalleye3t;

    float bodyR;
    float bodyG;
    float bodyB;

    float headR;
    float headG;
    float headB;

    float antigravityR;
    float antigravityG;
    float antigravityB;

    float eyeR;
    float eyeG;
    float eyeB;

    RobotExplode(int a_x, int a_y, int a_bodyHeight, int a_neckHeight){
        x = a_x;
        y = a_y;
        bodyHeight = a_bodyHeight;
        neckHeight = a_neckHeight;
        float ny = y - bodyHeight - neckHeight - headRadius;

        neck1s = new coordinate();
        neck1g = new coordinate();
        neck2s = new coordinate();
        neck2g = new coordinate();
        neck3s = new coordinate();
        neck3g = new coordinate();
        antenna1s = new coordinate();
        antenna1g = new coordinate();
        antenna2s = new coordinate();
        antenna2g = new coordinate();
        antenna3s = new coordinate();
        antenna3g = new coordinate();
        antigravity = new coordinate();
        body = new coordinate();
        stripe = new coordinate();
        head = new coordinate();
        bigeye = new coordinate();
        pupil = new coordinate();
        smalleye1 = new coordinate();
        smalleye2 = new coordinate();
        smalleye3 = new coordinate();

        updatecoordinates();

        //save change amount of coordinates
        //rotaterad is a paramater of rotation
        neck1st = new coordinate();
        neck1gt = new coordinate();
        neck2st = new coordinate();
        neck2gt = new coordinate();
        neck3st = new coordinate();
        neck3gt = new coordinate();
        antenna1st = new coordinate();
        antenna1gt = new coordinate();
        antenna2st = new coordinate();
        antenna2gt = new coordinate();
        antenna3st = new coordinate();
        antenna3gt = new coordinate();
        antigravityt = new coordinate();
        bodyt = new coordinate();
        stripet = new coordinate();
        headt = new coordinate();
        bigeyet = new coordinate();
        pupilt = new coordinate();
        smalleye1t = new coordinate();
        smalleye2t = new coordinate();
        smalleye3t = new coordinate();

        settarget();

        colorrandomize();
    }

    void colorrandomize(){
        bodyR = random(0, 255);
        bodyG = random(0, 255);
        bodyB = random(0, 255);

        headR = random(0, 255);
        headG = random(0, 255);
        headB = random(0, 255);

        antigravityR = random(0, 255);
        antigravityG = random(0, 255);
        antigravityB = random(0, 255);

        eyeR = random(0, 255);
        eyeG = random(0, 255);
        eyeB = random(0, 255);
    }

    void updatecoordinates(){
        ny = y - bodyHeight - neckHeight - headRadius;
        neck1s.x = x+2;     neck1s.y = y-bodyHeight;
        neck1g.x = x+2;     neck1g.y = ny;
        neck2s.x = x+12;    neck2s.y = y-bodyHeight;
        neck2g.x = x+12;    neck2g.y = ny;
        neck3s.x = x+22;    neck3s.y = y-bodyHeight;
        neck3g.x = x+22;    neck3g.y = ny;
        antenna1s.x = x+12; antenna1s.y = ny;
        antenna1g.x = x-18; antenna1g.y = ny-43;
        antenna2s.x = x+12; antenna2s.y = ny;
        antenna2g.x = x+42; antenna2g.y = ny-99;
        antenna3s.x = x+12; antenna3s.y = ny;
        antenna3g.x = x+78; antenna3g.y = ny+15;
        antigravity.x = x;  antigravity.y = y-33;
        body.x = x-45;      body.y = y-bodyHeight;
        stripe.x = x-45;    stripe.y = y-bodyHeight+17;
        head.x = x+12;      head.y = ny;
        bigeye.x = x+24;    bigeye.y = ny-6;
        pupil.x = x+24;     pupil.y = ny-6;
        smalleye1.x = x;    smalleye1.y = ny-8;
        smalleye2.x = x+30; smalleye2.y = ny-26;
        smalleye3.x = x+41; smalleye3.y = ny+6;
    }

    void settarget(){
        neck1st.x = random(0, width);  neck1st.y = random(0, height);
        neck2st.x = random(0, width);  neck2st.y = random(0, height);
        neck3st.x = random(0, width);  neck3st.y = random(0, height);
        antenna1st.x = random(0, width);   antenna1st.y = random(0, height);
        antenna2st.x = random(0, width);   antenna2st.y = random(0, height);
        antenna3st.x = random(0, width);   antenna3st.y = random(0, height);
        antigravityt.x = random(0, width); antigravityt.y = random(0, height);
        bodyt.x = random(0, width);    bodyt.y = random(0, height);
        stripet.x = random(0, width);  stripet.y = random(0, height);
        headt.x = random(0, width);    headt.y = random(0, height);
        bigeyet.x = random(0, width);  bigeyet.y = random(0, height);
        pupilt.x = random(0, width);   pupilt.y = random(0, height);
        smalleye1t.x = random(0, width);   smalleye1t.y = random(0, height);
        smalleye2t.x = random(0, width);   smalleye2t.y = random(0, height);
        smalleye3t.x = random(0, width);   smalleye3t.y = random(0, height);

        neck1st.rotaterad = random(-1,1);
        neck2st.rotaterad = random(-1,1);
        neck3st.rotaterad = random(-1,1);
        antenna1st.rotaterad = random(-1,1);
        antenna2st.rotaterad = random(-1,1);
        antenna3st.rotaterad = random(-1,1);
        bodyt.rotaterad = random(-1,1);
        stripet.rotaterad = random(-1,1);
    }
    //start and goal are initial coordinate before translate
    void rotateline(coordinate start, coordinate goal, float kakudo){
        pushMatrix();
        translate((start.x+goal.x)/2, (start.y+goal.y)/2);
        rotate(kakudo);
        line(start.x-(start.x+goal.x)/2, start.y-(start.y+goal.y)/2, goal.x-(start.x+goal.x)/2, goal.y-(start.y+goal.y)/2);
        popMatrix();
    }

    void rotaterect(coordinate point, int width, int height, float kakudo){
        pushMatrix();
        translate(point.x+width/2, point.y+height/2);
        rotate(kakudo);
        rect(point.x-(point.x+width/2), point.y-(point.y+height/2), width, height);
        popMatrix();
    }

    void display(){
        ny = y - bodyHeight - neckHeight - headRadius;
        //neck
        stroke(102);
        // pushMatrix();
        // point((neck1s.x+neck1g.x)/2, (neck1s.y+neck1g.y)/2);
        // translate((neck1s.x+neck1g.x)/2, (neck1s.y+neck1g.y)/2);
        // rotate(PI/2);
        // line(neck1s.x-(neck1s.x+neck1g.x)/2, neck1s.y-(neck1s.y+neck1g.y)/2, neck1g.x-(neck1s.x+neck1g.x)/2, neck1g.y-(neck1s.y+neck1g.y)/2);
        // popMatrix();
        rotateline(neck1s, neck1g, kakudo*neck1st.rotaterad);
        // line(neck2s.x, neck2s.y, neck2g.x, neck2g.y); //(276, 257, 276, 162);       //middle
        rotateline(neck2s, neck2g, kakudo*neck2st.rotaterad);
        // line(neck3s.x, neck3s.y, neck3g.x, neck3g.y); //(286, 257, 286, 162);       //right
        rotateline(neck3s, neck3g, kakudo*neck3st.rotaterad);

        //antenna
        // line(antenna1s.x, antenna1s.y, antenna1g.x, antenna1g.y);//(276, 155, 246, 112);       //small
        rotateline(antenna1s, antenna1g, kakudo*antenna1st.rotaterad);
        // line(antenna2s.x, antenna2s.y, antenna2g.x, antenna2g.y);//(276, 155, 306, 56);        //high
        rotateline(antenna2s, antenna2g, kakudo*antenna2st.rotaterad);
        // line(antenna3s.x, antenna3s.y, antenna3g.x, antenna3g.y);//(276, 155, 342, 170);       //middle
        rotateline(antenna3s, antenna3g, kakudo*antenna3st.rotaterad);

        //body
        noStroke();                     //no outline
        fill(antigravityR, antigravityG, antigravityB);//(102)                      //gray
        ellipse(antigravity.x, antigravity.y, 33, 33);//(264, 377, 33, 33);      //antigravity sphere
        fill(bodyR, bodyG, bodyB);//(0);                        //black
        // rect(body.x, body.y, bodyWidth, bodyHeight-33);//(219, 257, 90, 120);        //body
        rotaterect(body, bodyWidth, bodyHeight-33, kakudo*bodyt.rotaterad);
        fill(antigravityR, antigravityG, antigravityB);//(102);                      //gray
        // rect(stripe.x, stripe.y, bodyWidth, 8);//(219, 274, 90, 6);          //stripe
        rotaterect(stripe, bodyWidth, 8, kakudo*stripet.rotaterad);

        //head
        fill(bodyR, bodyG, bodyB);//(0);                        //black
        ellipse(head.x, head.y, headRadius, headRadius);//(276, 155, 45, 45);      //head
        fill(eyeR, eyeG, eyeB);//(255);                      //white
        ellipse(bigeye.x, bigeye.y, 14, 14);//(288, 150, 14, 14);      //big eye
        fill(bodyR, bodyG, bodyB);//(0);                        //black
        ellipse(pupil.x, pupil.y, 3, 3);//(288, 150, 3, 3);        //pupil:doukou
        fill(eyeR, eyeG, eyeB);//(153);                      //light gray
        ellipse(smalleye1.x, smalleye1.y, 5, 5);//(263, 148, 5, 5);        //small eye 1
        ellipse(smalleye2.x, smalleye2.y, 4, 4);//(296, 130, 4, 4);        //small eye 2
        ellipse(smalleye3.x, smalleye3.y, 3, 3);//(305, 162, 3, 3);        //small eye 3
    }

    void easing(){
        int targetX = mouseX;
        //int targetY = mouseY;
        x += (targetX-x) * ease;
        //y += (targetY-y) * ease;
        updatecoordinates();
    }

    void explode(){
        neck1s.x += (neck1st.x- neck1s.x) * explodeparam;            neck1s.y += (neck1st.y- neck1s.y) * explodeparam;
        neck2s.x += (neck2st.x- neck2s.x) * explodeparam;            neck2s.y += (neck2st.y- neck2s.y) * explodeparam;
        neck3s.x += (neck3st.x- neck3s.x) * explodeparam;            neck3s.y += (neck3st.y- neck3s.y) * explodeparam;
        neck1g.x += (neck1st.x- neck1s.x) * explodeparam;            neck1g.y += (neck1st.y- neck1s.y) * explodeparam;
        neck2g.x += (neck2st.x- neck2s.x) * explodeparam;            neck2g.y += (neck2st.y- neck2s.y) * explodeparam;
        neck3g.x += (neck3st.x- neck3s.x) * explodeparam;            neck3g.y += (neck3st.y- neck3s.y) * explodeparam;
        antenna1s.x += (antenna1st.x- antenna1s.x) * explodeparam;   antenna1s.y += (antenna1st.y- antenna1s.y) * explodeparam;
        antenna2s.x += (antenna2st.x- antenna2s.x) * explodeparam;   antenna2s.y += (antenna2st.y- antenna2s.y) * explodeparam;
        antenna3s.x += (antenna3st.x- antenna3s.x) * explodeparam;   antenna3s.y += (antenna3st.y- antenna3s.y) * explodeparam;
        antenna1g.x += (antenna1st.x- antenna1s.x) * explodeparam;   antenna1g.y += (antenna1st.y- antenna1s.y) * explodeparam;
        antenna2g.x += (antenna2st.x- antenna2s.x) * explodeparam;   antenna2g.y += (antenna2st.y- antenna2s.y) * explodeparam;
        antenna3g.x += (antenna3st.x- antenna3s.x) * explodeparam;   antenna3g.y += (antenna3st.y- antenna3s.y) * explodeparam;
        antigravity.x += (antigravityt.x- antigravity.x) * explodeparam;
        antigravity.y += (antigravityt.y- antigravity.y) * explodeparam;
        body.x += (bodyt.x- body.x) * explodeparam;                  body.y += (bodyt.y- body.y) * explodeparam;
        stripe.x += (stripet.x- stripe.x) * explodeparam;            stripe.y += (stripet.y- stripe.y) * explodeparam;
        head.x += (headt.x- head.x) * explodeparam;                  head.y += (headt.y- head.y) * explodeparam;
        bigeye.x += (bigeyet.x- bigeye.x) * explodeparam;            bigeye.y += (bigeyet.y- bigeye.y) * explodeparam;
        pupil.x += (pupilt.x- pupil.x) * explodeparam;               pupil.y += (pupilt.y- pupil.y) * explodeparam;
        smalleye1.x += (smalleye1t.x- smalleye1.x) * explodeparam;   smalleye1.y += (smalleye1t.y- smalleye1t.y) * explodeparam;
        smalleye2.x += (smalleye2t.x- smalleye2.x) * explodeparam;   smalleye2.y += (smalleye2t.y- smalleye2t.y) * explodeparam;
        smalleye3.x += (smalleye3t.x- smalleye3.x) * explodeparam;   smalleye3.y += (smalleye3t.y- smalleye3t.y) * explodeparam;

        kakudo+= (PI*5-kakudo) * kakudoparam;
    }
}
