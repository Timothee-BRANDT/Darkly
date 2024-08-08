# Finding Hidden Directories or Files on a Website

## Overview

To uncover hidden directories or files on a website, you can use the `dirb` package which is a web content scanner. This tool scans a website by attempting to access a list of common directories and files.

Start by scanning the website:

```sh
dirb http://127.0.0.1:8080/
```

After the scan, you will see this line in the results:

```
http://127.0.0.1:8080/robots.txt (CODE:200|SIZE:53)
```

This indicates that the `robots.txt` file is present on the server and can be accessed.

## Analyzing the robots.txt File

Visit the link to the robots.txt file:

```
http://127.0.0.1:8080/robots.txt
```

The content of this file look like this:

```
User-agent: *
Disallow: /whatever
Disallow: /.hidden
```

The `robots.txt` file is used to instruct web crawlers on which directories or files they should avoid indexing. In this case, the file indicates that the `/whatever` and `/.hidden` directories should not be accessed by crawlers.

## Exploring the .hidden Directory

Next, navigate to the `.hidden` directory:

```
http://127.0.0.1:8080/.hidden/
```

Inside, you can find a `README` file along with multiple subfolders, each containing its own `README` file, and so on. Given this structure, it's likely that one of these `README` files contains a flag.

## Extracting the Flag

To efficiently search through all the `README` files and locate the flag, you can use the following command to download all `README` files:

```sh
wget -r -e robots=off -nH -A README -P downloaded_files http://127.0.0.1:8080/.hidden/
```

- `-r`: Recursively download files.
- `-e` robots=off: Ignore the robots.txt rules.
- `-nH`: Disable the creation of host directories.
- `-A` README: Only download files named README.
- `-P` downloaded_files: Save the files in the downloaded_files directory.

After downloading, search for the flag within the files using grep:

```sh
grep -r "flag" downloaded_files/
```

The result might look like this:

```sh
downloaded_files/.hidden/whtccjokayshttvxycsvykxcfm/igeemtxnvexvxezqwntmzjltkt/lmpanswobhwcozdqixbowvbrhw/README:Hey, here is your flag: d5eec3ec36cf80dce44a896f961c1831a05526ec215693c8f2c39543497d4466
```

The flag is: `d5eec3ec36cf80dce44a896f961c1831a05526ec215693c8f2c39543497d4466`

