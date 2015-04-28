# prepare4web

### Outline

If you want to upload photo from your digital camera on any of the web portal or social network say Picasa, Flickr, Facebook, Vkontakte etc. then you should reduce the size of the same before doing so. 
This tool is designed to resize images from a folder in batch processing which means you can reduce the size of images in a folder on a single click.


### Contents

The script itself contains in *core.cmd*, but you should not invoke it directly.
Instead use scripts with pre-defined basic parameters for specific purpose:

* prepare4web - most common parameters for the web publishing
* prepare4vk - for Vkontakte social network
* prepare4fb - for facebook

### Usage
`prepare4web <filename of foldername>`

Also you can create shortcut to this script and use drag&drop to prepare photos (both single photo or whole folder)

Final photos will be saved in the subfolder naming _webNxM_, where _N_ and _M_ are dimensions of reduced images

### Requirements
This script require morgify utility from the **ImageMagick** package (version 6.9.1-2 or newer is recomended). You can [download package from official site](http://imagemagick.com/script/binary-releases.php)

It also use **ExifTool** to strip final images from unnecessary or unwanted informatio. [Download link](http://www.sno.phy.queensu.ca/~phil/exiftool/)

### Install
Please unpack or place Imagemagick files in folder where script is located. Also copy exiftool.exe into this folder.