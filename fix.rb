module Fix
  Patch = Struct.new(:method, :from, :to)

  FIX_DATA = {
    'book.opf' => [
      # cover page 属性の設定方法変更
      Patch.new(:sub,
                %r(<meta name="cover" content="fig-cover"/>),
                ''),
      Patch.new(:sub,
                %r("images/cover.jpg" media-type="image/jpeg"),
                '\& properties="cover-image"'),
    ],
    
    'chap1.html' => [
      # typo
      Patch.new(:sub, /をを/, 'を'),
    ],
    'chap2.html' => [
      # 図番号への変更
      Patch.new(:sub, /（redmine-register\.png）/, '（図2.1）'),
      Patch.new(:sub, /（newticket.png）/, '（図2.2）'),
    ],
    'chap3.html' => [
      # typo
      Patch.new(:sub, /setupr\.bは/, 'setup.rbは'),
      
      # 図番号への変更
      Patch.new(:sub, /（newprojwiz.png）/, '（図3.1）'),
      Patch.new(:sub, /（projinitsetting.png）/, '（図3.2）'),
      Patch.new(:sub, /（useextsetting.png）/, '（図3.3）'),
      Patch.new(:sub, /（debugsetting.png）/, ''),
      Patch.new(:sub, /（buildsolution.png）/, '（図3.4）'),
      Patch.new(:sub, /（debugconfigprop.png）/, '（図3.5）'),
      Patch.new(:sub, /（debugconfig.png）/, '（図3.6）'),
      Patch.new(:sub, /（breakpoint.png）/, '（図3.7）'),
      Patch.new(:sub, /（needrebuild.png）/, '（図3.8）'),
      Patch.new(:sub, /（break.png）/, '（図3.9）'),
      Patch.new(:sub, /（dln.c.png）/, '（図3.10）'),
      Patch.new(:sub, /（newfilter.png）/, '（図3.11）'),
      Patch.new(:sub, /（addtest.png）/, '（図3.12）'),
    
      # タグ付け不備（漏れ）修正 && ネスト構造変更
      Patch.new(:sub,
                %r!(オブジェクトとして登録する。)</li>\n</ul>!, '\1'),
      Patch.new(:sub,
                %r!\n+\* (名前を付けて定数またはグローバル変数に登録する。)\n</dd>\n</dl>!m,
                "</dd>\n</dl>\n</li>\n<li>\\1"),
      Patch.new(:sub, %r!汚染を小さくできます。</p>!, "\\&\n</li>\n</ul>"),
      Patch.new(:sub,
                %r!(Stringオブジェクト)</li>\n</ul>!m, '\1'),
      Patch.new(:sub,
                %r!(ruby\\encoding\.h</b>): (.*?)\t(.*?)</p>!,
                "\\1</p>\n<dl>\n<dt>\\2</dt>\n<dd>\\3</dd>\n</dl>"),
      Patch.new(:sub,
                %r!<ul>(\n<li>Fixnumオブジェクト)</li>\n</ul>!m,
                "</li>\\1"),
      Patch.new(:sub,
                %r!(ruby\\ruby\.h</b>): (.*?)\t(.*?)</p>!,
                "\\1</p>\n<dl>\n<dt>\\2</dt>\n<dd>\\3</dd>\n</dl>"),
      Patch.new(:sub,
                %r!<ul>(\n<li>Numericオブジェクト)</li>\n</ul>!m,
               "</li>\\1"),
      Patch.new(:gsub,
                %r!\n+\* (Arrayオブジェクト|Hashオブジェクト)\n</dd>\n</dl>!m,
                "</dd>\n</dl>\n</li>\n<li>\\1"),
      Patch.new(:sub,
                %r!<dd>空のHashオブジェクトを生成します。\n</dd>\n</dl>!,
                "\\&\n</li></ul>"),
      Patch.new(:sub,
                %r!(ruby\\ruby\.h</b>): (.*?)\t(.*?): (.*?)\t(.*?): (.*?)\t(.*?)</p>!,
                "\\1</p>\n<dl>\n<dt>\\2</dt>\n<dd>\\3</dd>\n" + 
                "<dt>\\4</dt>\n<dd>\\5</dd>\n" +
                "<dt>\\6</dt>\n<dd>\\7</dd>\n</dl>\n"),
    ],
  }

  def self.fix(src_dir, dst_dir = nil)
    dst_dir ||= src_dir
    FIX_DATA.each do |filename, data|
      doc = ''
      open("#{src_dir}/#{filename}", 'r:utf-8') { |f| doc = f.read }
      doc = data.inject(doc) { |a, e| a.send(e.method, e.from, e.to) }
      open("#{dst_dir}/#{filename}", 'w:utf-8') { |f| f.write(doc) }
    end
  end
end
