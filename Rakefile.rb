require 'fix'

EPUB_MASTER = 'Ruby環境構築講座Windows編-1.0.1.epub'

task :default => 'book.mobi'

desc 'create mobi file'
file 'book.mobi' => :fix do
  # sh 'kindlegen OEBPS/book.opf'
end

desc 'fix type and others'
task :fix => 'OEBPS' do
  Fix.fix('OEBPS')
  # Fix.fix('OEBPS', 'OEBPS.patch')
end

desc 'extract OEBPS directory'
file 'OEBPS' => EPUB_MASTER do
  sh "7z x #{file} OEBPS"
end
