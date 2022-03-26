# AHKHID-Roccat-Arvo
- AHKHID script for Roccat Arvo keyboard macro keys. The official software never worked for me.
- I used this to use the macro keys as media keys.
- This repo contains also the 3 corrected examples with the line `#include AHKHID.ahk` as discovered from this thread:  https://github.com/jleb/AHKHID/issues/5
## How to use it
- Install Autohotkey
- Place the file `media.ahk` in the same folder as `AHKHID.ahk`
- Edit the file `media.ahk` in the lines with `Send` in order to set the behaviour of the macro keys (right click -> edit)
- Run the file (double click)
- Not tested: If you want it to start at startup read this: https://stackoverflow.com/questions/41723490/how-to-build-ahk-scripts-automatically-on-startup
## Other Info
- The data value you see in `example2.ahk` are in hexadecimal format but in the script I used decimal, so they differ. There is a MsgBox you can uncomment to see the decimal value of data when you press the key.
- To find the device look in the "Other" tab of example1. There will be many, simply test them one by one by copying the values of Usage Page and Page into example2 (in this case the correct ones are 12 and 1), click "Add" and then "Call". Now if you press the macro keys (and the values of Usage Page and Page are correct) you should see something appearing in the lower section. Save the values of VendorID, ProductID, Usage Page and Page and put them in my script if yours are different from mine.
## Other examples on which i based my code:
- https://www.autohotkey.com/board/topic/38015-ahkhid-an-ahk-implementation-%20of-the-hid-functions/
- First part of the post by TheGood to identify the device
- Post by b0ring for the code structure
