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

