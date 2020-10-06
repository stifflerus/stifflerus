---
layout: post
title: How to Eliminate Bed Rattle on Prusa i3 MK3S
---

I have finally entered the world of 3D printing with the purchase of my Prusa i3 MK3S kit.
It's been a great printer so far, and I look forward to using it, mostly for printing 
functional and replacement parts. It has one annoying problem though, and that is a very noisy
rattle coming from the bed during printing.

I've come up with two solutions to eliminate the rattle. Stupidly, I did
them both at the same time so I'm not actually sure which was most effective.

## Pack the Linear Bearings with Grease

The bed of the Prusa i3 rides on LM8UU linear ball bearings. These bearings slide along 8mm 
smooth rods. There has to be a small amount of clearance between the
linear bearing and the smooth rod, otherwise the bearings would seize up. This play in the
bearings is the source of the bed rattle.

From the factory, the LM8UU bearings come prelubricated with a light oil. The Prusa assembly
instructions say that no additional lubrication is necessary. My theory is that packing the
bearings with grease anyway will add enough "stickiness" to prevent the bearings from rattling
so much.

I used a [printable cap that fits tubes of Super Lube](https://www.thingiverse.com/thing:1128781) to pack grease into the bearings. I printed this in PLA. 

After packing, the bearings have noticeable drag when sliding on the smooth rods. This additional
resistance might help reducing ringing, but I'm not sure. I ended up tearing the whole machine
apart and greasing all the bearings, because it seemed like the right thing to do.

## Replace U-Bolts on Bed Frame

The LM8UU bearings are held to the bottom of the bed frame by u-bolts. 
This is pretty janky, even more so than the zipties holding things together. 
The u-bolts concentrate clamping force in a small area of the bearings, 
making them sensitive to overtighting. I believe this connection is also too
rigid, causing the bearings to rattle more than they would otherwise.

I printed [bearing holders](https://www.thingiverse.com/thing:710913) to mount the bearings on the bed frame without u-bolts. I printed these in Prusa orange PETG. My theory is that the less rigid bearing holders will work like
dampers to reduce rattle in the bearings. The design holds the bearings fully away from the bed frame, so there is no metal-on-metal contact.

As a consequence of this modification, the bed sits about 2mm higher. This isn't a big
deal as far as lost print volume goes, but it does cause two additional problem. 

Firstly, the Y-axis belt no longer aligns with the tensioner on the bottom of the bed frame. 
This was an easy fix. I printed an [extended Y-axis belt tensioner](https://www.thingiverse.com/thing:1548690), which fixed the problem. This was also printed in the Prusa orange PETG.

Secondly, the printer will now fail XYZ calibration, and might even crash the nozzle into the
bed. This is because the Z-axis is now 2mm shorter than the printer expects. Fixing this
problem requires modifying the printer firmware with a shorter Z-axis length.

### Firmware Modification

Making this modification was incredibly easy. Hats off to the Marlin and Prusa teams for
creating a codebase that isn't complete garbage.

1. Clone the [Prusa firmware](https://github.com/prusa3d/Prusa-Firmware) from GitHub.
2. Checkout out the latest version of the firmware. `git checkout v3.9.1`, in my case.
3. Follow the instructions in the README to set up your build environment. I use Debian 
GNU/Linux, so setup was as easy as `sudo apt install gawk && ./build.sh`. This automagically
downloads all of the build dependencies and builds the firmware.
  * I'm not a big fan of build scripts that download their own dependencies, but I have to admit
    this is easy and convenient.
  * I don't like that it creates build and environment directories in the parent of the git repository. These should be children of the git repository directory.
4. For the MK3S, copy the firmware variant file to the `./Firmware` directory. `mv ./Firmware/variants/1_75mm_MK3S-EINSy10a-E3Dv6full.h ./Firmware/Configuration_prusa.h`. This overwrites the destination file with the configuration for the MK3S.
5. Edit `./Firmware/Configuration_prusa.h`. There is a parameter called `Z_MAX_POS` that defines
the length of the Z-Axis. I changed mine to `208`. You might need to fiddle with this if calibration still fails or the nozzle still crashes into the bed.
6. Compile the firmware using `./build.sh`. The hex file is output to `../Prusa-Firmware-build/Firmware.ino.hex`
7. Update the printer firmware using the usual utility in PrusaSlicer.
8. Perform an XYZ calibration on the printer. Make sure to watch the calibration in case the nozzle crashes into the bed! If this happens, or the printer still fails calibration, decrease the value of `Z_MAX_POS`.

### Update Printer Settings in PrusaSlicer

You could probably skip this step unless you plan to print things utilizing the full printer build height. 
Without it, PrusaSlicer will allow you to slice objects that are too tall for the printer by an amount equal to however much `Z_MAX_POS` was decreased (2mm in my case).

In PrusaSlicer, go to the "Printer Settings" tab. Change the value of "Max print height" to your value for `Z_MAX_POS` (208 in my case). Save, and repeat for other profiles.

## Results

The results of all this work is that the bed rattle is gone! I'm still not sure which solution
fixed the problem, but I am sure that I like my nice, quiet printer. 
I'm also glad that I got an opportunity to dip my toes into the firmware modification waters.
I've had very frustrating experiences with firmware for other devices in the past, and likely would have never touched the firmware for my printer if it wasn't for this project. Now that
I see how easy it is, I'm likely to make other modifications in the future. 
