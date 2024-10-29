#include <gb/gb.h>
#include "SimpleSprite.h"

uint8_t spriteX,spriteY;
int8_t velocityX,velocityY;
uint8_t joypadCurrent=0,joypadPrevious=0;

void main(void)
{
    DISPLAY_ON;
    SHOW_SPRITES;

    set_sprite_data(0,1,SimpleSprite);
    set_sprite_tile(0,0);
    move_sprite(0,84,88);

    // Set our default position
    spriteX=80;
    spriteY=72;

    // Set our default velocity to be moving down and to the right
    velocityX=0;
    velocityY=0;

    // Loop forever
    while(1) {

        // We'll need to check the joypad input twice
        // never call "joypad()" more than once per frame
        // We'll save it's current value and check that variable
        joypadPrevious=joypadCurrent;
        joypadCurrent = joypad();

        // If the right button on the d-pad is held down
        if(joypadCurrent & J_RIGHT){

            // Positive x velocity to move the sprite to the right
            velocityX=1;

        // If the right button on the d-pad is held down
        }else if(joypadCurrent & J_LEFT){

            // negative x velocity to move the sprite to the left
            velocityX=-1;
        }else{

            // Zero x velocity means no horizontal movement
            velocityX=0;
        }

        // If the "A" button was just pressed
        if((joypadCurrent & J_A) && !(joypadPrevious & J_A)){

            // Move the sprite downward
            spriteY+=8;

        // If the "B" button was just presssed
        } else if((joypadCurrent & J_B) && !(joypadPrevious & J_B)){

            // Move the sprite up
            spriteY-=8;
        }

        // Apply our velocity
        spriteX+=velocityX;
        spriteY+=velocityY;

        // Position the first sprite at our spriteX and spriteY
        // All sprites are render 8 pixels to the left of their x position and 16 pixels ABOVE their actual y position
        // This means an object rendered at 0,0 will not be visible
        // x+5 and y+12 will center the 8x8 tile at our x and y position
        move_sprite(0,spriteX+4,spriteY+12);

		// Done processing, yield CPU and wait for start of next frame
        wait_vbl_done();
    }
}