## Safari Reading List to HTML

Get Safari's Reading List with Ruby

Getpocket or like apps need a html file for to import Safari's Reading List. I wrote code for to export my Safari Reading List on macOS. I leveraged Ruby, but this methodology could be easily ported to other languages like Bash, Python, or Objective C.

### First, make sure you have the plist gem:

```ruby
$ gem install plist
```

### Then fetch Safari's Reading List and Write a file:

```ruby
# safari-readling-list-to-html.rb

require "plist"

begin
  bookmarks_xml = `plutil -convert xml1 -o - ~/Library/Safari/Bookmarks.plist`
  urls = Plist.parse_xml(bookmarks_xml)["Children"].select{|e|e["Title"]=="com.apple.ReadingList"}[0]["Children"].map{|e| '<DT><A HREF="' + e["URLString"] + '">' + e["URIDictionary"]["title"] + '</A>'}
  
  plistname = "Safari-Reading-List.html"
  bookmarkfile = File.open(plistname, "w")
  bookmarkfile.puts '<!DOCTYPE NETSCAPE-Bookmark-file-1>'
  bookmarkfile.puts '<HTML>'
  bookmarkfile.puts '<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=UTF-8">'
  bookmarkfile.puts '<Title>Bookmarks</Title>'
  bookmarkfile.puts '<H1>Bookmarks</H1>'
  bookmarkfile.puts urls
  bookmarkfile.puts "</HTML>"
  bookmarkfile.close

end
```
This snippet is just a starting point; feel free to customize it for your specific use case.

## Basic Usage

Open your terminal and create file,

```ruby
$ touch safari-readling-list-to-html.rb
```

Open file and paste code,

```ruby
$ nano safari-readling-list-to-html.rb
```
Run ruby file,

```ruby
$ ruby safari-readling-list-to-html.rb
```
Check the html file.