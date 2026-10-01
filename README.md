# ibiblio Icon Archive

## Preserving History

In the 1990s, ibiblio.org hosted an icon library featuring around 7,200 icons in GIF format, made freely available to the world.
This icon library was mirrored to various places, but by 2026 the only remaining copy seemed to be at
[www.ibiblio.org/gio/iconbrowser](https://www.ibiblio.org/gio/iconbrowser/),
a page that was hard to navigate and use (depending on server-side image maps and featuring a search engine that didn't work).

As an effort to preserve these icons as a part of Internet history, I automated the extraction of all of the files and rehosted
them on a modern mirror at [ibiblio-icon-archive.danq.dev](https://ibiblio-icon-archive.danq.dev/). This retains broradly the same user interface while removing
the server-side image maps (which probably existed only to save on simultaneous download streams by browsers of its day; a
limitation that does not exist under modern HTTP/2 delivery) and repairing the search. I've also made all the icons available
to download in bulk, via this repository.

## Building the Archive

You can build the archive for yourself to browse offline. You will need a copy of [Ruby](https://www.ruby-lang.org/) version 3.3 or higher and
[ImageMagick](https://imagemagick.org/) version 7 or higher.

1. Check out this repository to your local computer.
2. Run `ruby build.rb`; this will (re)generate -
    - a `.json` file with image metadata about each icon, unless these already exist and are less than a day old,
    - a `.html` file for each "page" of icons, and
    - an `index.html` to start browsing from (this also embeds JSON metadata about all the images, used to enable the JavaScript-powered search)

`./pre-scripts/` contains the temporary programs I used to extract in-bulk the images from their original home.

## License

I release all original code in this repository into the Public Domain. Do whatever you like with it.

I can't speak to the copyright status of the icons themselves. They were widely and publicly shared around the Internet in the 1990s and were at that
point widely assumed to be in the Public Domain, but I've not yet been able to identify their artist(s) and verify this conclusively.
