desc "Build EPUB"

task :default => "build"


# �ϊ�����EPUB�𐶐����܂�
task :build do
  puts '-- make ReVIEW files --'
  sh 'ruby ch2rv.rb dat'

  puts '-- build EPUB --'
  Dir.chdir("./dat/rv")
  sh 'review-epubmaker config.yaml'
  Dir.chdir("../..")
  sh "mv ./dat/rv/*.epub ./dat"
end


# �ϊ�����EPUB�𐶐��A�f�o�b�O�p��ReVIEW�̐����t�@�C�����c��
task :debug do
  puts '-- make ReVIEW files --'
  sh 'ruby ch2rv.rb dat'

  puts '-- build EPUB --'
  Dir.chdir("./dat/rv")
  sh 'review-epubmaker debug.yaml'
  Dir.chdir("../..")
  sh "mv ./dat/rv/*.epub ./dat"
end
