# encoding: utf-8
#
# Copyright (c) 2012 Shunsuke Ito
#
# This program is free software.
# You can distribute or modify this program under the terms of
# the GNU LGPL, Lesser General Public License version 2.1.
#

require 'cgi'
require 'uri'
require 'FileUtils'

def url2link_of_string(html_string,options={})
    str = html_string.dup
    uri_reg = URI.regexp(%w[http https])
    str.gsub!(uri_reg) {%Q{<a href="#{$&}" target="_blank">#{$&}</a>}}
    return str
end

def make_reBody(str)
    body = str.gsub("<br>","@@br@@")
    body = body.gsub(/<\/?[^>]*>/, "")
    body = CGI.unescapeHTML(body)
    body = CGI.escapeHTML(body)
    body = url2link_of_string(body)
    body = body.gsub("@@br@@","<br />")
    
    return body
end

unless ARGV[0].nil? then
    if File.exist?(ARGV[0] + "/subject.txt")
        baseDir = File.realdirpath( ARGV[0] )
        subjectFile = File.realdirpath( ARGV[0] + "/subject.txt" )
        puts "-_-) < find :" + subjectFile
        
        #CHAPS
        chaps = ""
        #PART
        part = ""
        
        #read subject.txt
        f = open(subjectFile, "r:windows-31j:utf-8")
        subjects = f.readlines();
        f.close
        
        #mkdir rv
        rvDir = baseDir + "/rv"
        FileUtils.mkdir_p(rvDir) unless FileTest.exist?(rvDir)

        subjects.each{|subject|
            s = subject.split("<>")
            datFile = baseDir + "/" +s[0]
            threadTitle = s[1].chomp

            if File.exist?(datFile)
                ln = 1
                reFile = s[0].match(/(.+)(.dat$)/)[1] << ".re"
                title = threadTitle.match(/(.+)(\s\S+$)/)[1]
                reData = %Q(= #{title}\n)
                
                chaps << reFile << "\n"
                part << title << "\n"
                
                # read *.dat file
                f = open(datFile, "r:windows-31j:utf-8")
                dat = f.readlines();
                f.close
                
                dat.each{|line|
                    kakiko = line.split("<>")
                    body = make_reBody(kakiko[3])
                    reData << %Q(: #{ln.to_s} @<raw>{|html|名前: <b>#{kakiko[0]}</b> : )
                    reData << %Q(<span class="date">#{kakiko[2]}</span> }\n)
                    reData << %Q( @<raw>{|html|#{body}}\n)
                    ln += 1
                }
                
                f = open("#{rvDir}/#{reFile}", "w")
                f.write(reData)
                f.close
            end
        }
        
        # CHAPS
        f = open("#{rvDir}/CHAPS", "w")
        f.write(chaps)
        f.close

        # PART
        f = open("#{rvDir}/PART", "w")
        f.write(part)
        f.close

        #copy Asset Files
        FileUtils.cp(Dir.glob("./assets/*"), rvDir)
        
        puts "-_-) < ...done : #{rvDir}"
        
    else
        puts "-_-; < Not found : #{ARGV[0]}/subject.txt"
    end
else
    puts "-_-) < ruby ch2rv.rb [directory]"
end
