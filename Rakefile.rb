file = 'Ruby環境構築講座Windows編-1.0.1.epub'
#file = 'ruby.epub'

def fix_chap1
  name = 'OEBPS/chap1.html'
  doc = ''
  open(name, 'r:utf-8') { |f| doc = f.read }
  doc.sub!(/をを/, 'を')
  open(name, 'w:utf-8') { |f| f.write(doc) }
end

def fix_chap3
  name = 'OEBPS/chap3.html'
  doc = ''
  open(name, 'r:utf-8') { |f| doc = f.read }
  doc.sub!(/setupr\.b/, 'setup.rb')
  open(name, 'w:utf-8') { |f| f.write(doc) }
end

def fix_opf
  name = 'OEBPS/book.opf'
  doc = ''
  open(name, 'r:utf-8') { |f| doc = f.read }
  %q("images/cover.jpg" media-type="image/jpeg")
  doc.sub!(%r("images/cover.jpg" media-type="image/jpeg"), '\& properties="cimage"')
  open(name, 'w:utf-8') { |f| f.write(doc) }
end


task :default => 'book.mobi'

desc 'create mobi file'
file 'book.mobi' => :patch do
  sh 'kindlegen OEBPS/book.opf'
end

task :patch => 'OEBPS' do
  fix_chap1
  fix_chap3
  fix_opf
end

desc 'extract OEBPS directory'
file 'OEBPS' => file do
  sh "7z x #{file} OEBPS"
end
