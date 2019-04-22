---
layout: post
title: My Adventure Shucking WD Easystores in 2019
---

Recently I suffered a hard drive failure on my home server. Seeking a better and
more voluminous storage solution, I decided that my best options was to obtain
new hard drives through a process called shucking.

## The Failure That Started It All
My home server consisted of 3x3TB Seagate Barracuda drives arranged in a RAID5
configuration. This yielded a total usable storage capacity of 6TB. Around two
weeks ago, I logged in to shutdown the server so that I could move it to a
different location in my apartment. Before the shutdown, I did a routine check
of the RAID array status. That's when I discovered that one of the disks had
failed and had been dropped from the array.

I suffered no data loss because of the single failure redundancy
of RAID5, but also because I have backups. See:
[RAID is not a backup](https://serverfault.com/questions/2888/why-is-raid-not-a-backup).
The event spurred my decision to get new drives for the server because of a
number of factors:
* Seagate Barracuda drives are not designed to run in a RAID configuration
* A rebuild would likely result in more drive failures, and a need for new drives anyway
* I was already low on storage and this was an excuse to build a bigger array

## What Is Shucking?
I learned about shucking from the [/r/datahoarders](https://www.reddit.com/r/DataHoarder/)
subreddit. There is a lot of information there if you are interested in shucking
drives yourself, so I won't bore you with the details here. In a nutshell,
shucking is when you take an external hard drive, and remove the case so that the
bare drive can be used in a regular computer.
That sound like a ridiculous way to go about obtaining hard drives, until you
realize that you can save _a lot_ of money by doing it this way.

The target of my shuck was
[WD Easystore 8TB external hard drives](https://www.bestbuy.com/site/wd-easystore-8tb-external-usb-3-0-hard-drive-black/5792401.p?skuId=5792401). Inside of these is a high-quality
drive that is made specifically to operate as part of a RAID array. They used to
contain WD Red drives, but my research told me I should expect "white label" drives.
However, white labels drives are functionally identical to the WD Red drives. At
the time I purchased them, the Easystores were priced at $160, and the WD Reds
were $250. That's a savings of **$90 per drive**!

## Shucking
Shucking was surprisingly easy. There are a ton of videos online showing how to do
it without breaking the tabs that hold the plastic case together. I found that the
easiest way to open the case without breaking it is to use two small screwdrivers.
Stick the screwdrivers into the gap between the front panel and the C-shaped piece
of plastic that runs over the top, down the back, and under the bottom of the
case. You want one screwdriver on the top, and one screwdriver on the bottom. Use
the screwdrivers to leverage the case open. The only thing holding the case together
are four plastic tabs at the back of the case. The top and bottom do not have tabs.
If you use the screwdrivers to force the C-shaped piece of plastic straight back,
the four tabs will pop open, and the C-shaped piece of plastic will slide out with
the hard drive.

## Results
I got four 8TB "white label" drives, model WDC WD80EMAZ-00WJTA0. Most importantly,
they all report support for [TLER](https://en.wikipedia.org/wiki/Error_recovery_control),
the missing feature that made my Barracudas unsuitable for use in a RAID array:
```
SCT Error Recovery Control:
          Read:     70 (7.0 seconds)
          Write:     70 (7.0 seconds)
```
One caveat of the "white label" drives is that sometimes they won't spin up in
a regular computer due to non-standard usage of the 3.3V SATA pins. Apparently,
the external hard drive control board uses the 3.3V signal to tell the drive to
spin down. Standard computers don't do this, but they do supply 3.3V to the drive.
This prevents the drive from spinning up. This can be remedied by masking off the
3.3V pins on the drive with tape, or simply snipping the pins off with clippers.
Either method works.

Two of my drives required modification to the 3.3V pin. The other two did not. This
can be explained because all four of the drive were manufactured at different times.
Only the newer drives required the 3.3V fix. Having drives of different ages is
actually a reliability bonus, since manufacturing defects tend to affect all
drives in a batch more frequently.
