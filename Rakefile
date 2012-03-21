desc "Build EPUB"

task :default => "build"


# 変換してEPUBを生成します
task :build do
  puts '-- make ReVIEW files --'
  sh 'ruby ch2rv.rb dat'

  puts '-- build EPUB --'
  Dir.chdir("./dat/rv")
  sh 'review-epubmaker config.yaml'
  Dir.chdir("../..")
  sh "mv ./dat/rv/*.epub ./dat"
end


# 変換してEPUBを生成、デバッグ用にReVIEWの生成ファイルを残す
task :debug do
  puts '-- make ReVIEW files --'
  sh 'ruby ch2rv.rb dat'

  puts '-- build EPUB --'
  Dir.chdir("./dat/rv")
  sh 'review-epubmaker debug.yaml'
  Dir.chdir("../..")
  sh "mv ./dat/rv/*.epub ./dat"
end
