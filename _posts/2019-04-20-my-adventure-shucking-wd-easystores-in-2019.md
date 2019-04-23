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
That may sound like a ridiculous way to go about obtaining hard drives, until you
realize that you can save _a lot_ of money by doing it that way.

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
Stick the screwdrivers into the gap between the black front panel and the gray
back panel. You want one screwdriver at the top, and one screwdriver at the bottom. Use
the screwdrivers to pry against the inside of the front panel and
leverage the case open. The only thing holding the case together
are four plastic tabs at the back. The top and bottom do not have tabs.
If you force the gray back panel straight back,
the four tabs will pop open, and the back panel will slide out with
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

## Reuse
I retired the old Seagate drives into the Easystore enclosures. They function perfectly
and I now have 3x3TB external hard drives. Strangely enough, all of the drives
work, despite one having been failed from the array. This is likely due to the
lack of TLER on these drives. What likely happened is a drive encountered a bad
sector and tried several time to reread it. Normally this is okay, and sometimes a
drive is able to read the sector after a few tries. The problem is that this messes
up the RAID controller (linux software RAID in this case). The RAID controller
sees the drive stop responding for a long time and assumes that the drive has died.
In reality, only a single sector has failed, but the drive is frozen trying to read it.
This is the problem the TLER fixes. It sets a time limit for the drive to try
rereading bad sectors. That way, the drive is never frozen long enough to be failed
out of a RAID array.

## New Server
The new home server is up and running. I decided to go with 4x8TB drives in a
RAID6 array. This gives me a total usable storage capacity of 16TB. RAID6 also
has double redundancy. This means that the array can withstand two simultaneous drive
failures without loss of data.

The reason I decided to use RAID6 is twofold. Firstly,
[RAID5 stopped working in 2009](https://www.zdnet.com/article/why-raid-5-stops-working-in-2009/).
The rate of URE (unrecoverable read errors) per unit of data has not improved much
over time, while hard drive size has increase dramatically. This means that UREs
are *more likely* with larger drive sizes. The odds of a rebuild failure are high with a RAID5
array. If a URE occurs on any of the remaining drives during a RAID5 rebuild,
all data is lost, since there is no redundancy in the degraded state. Since any of
drives can fail the entire rebuild, the risk of failure is the sum of the risk of
all drives combined. RAID6 has a second level of redundancy, so a single URE does not cause the rebuild to fail.

Secondly, if in the future I decide to add more drives, RAID6 has a better usable
storage ratio than alternatives such as RAID1+0. RAID6 always uses two drives for
parity, whereas RAID1+0 always uses half the number of drives in the array for
parity. With only four drives, the usable storage ratio is the same between the
two RAID levels. However, if more drives are added, RAID6 has the advantage of
more usable storage, since the number of drives of parity is constant. RAID1+0 does
have some advantages with reliability, however, my server is primarily for storing media,
so ultra-high reliability is not really necessary. Nor are media files so important
that losing them would be devastating. Also, as I said before, RAID is not a backup.
