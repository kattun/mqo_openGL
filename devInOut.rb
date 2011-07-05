require 'inconsole'
require 'system'
require 'glnihongo'
require 'opengl'
require 'chasen'
require 'devNews'
require 'pp'
require 'nkf'
include Gl,Glut

class Input
	def initialize(xpos, ypos, height)
		@console = VRLocalScreen.newform(nil,WStyle::WS_BORDER, InConSole)
		@console.move(xpos, ypos + height*0.8, $width, 80)
		@console.caption = "input"
		@console.create.show
	end
	def inconsole()
		VRLocalScreen.messageloop
	end
end

class Output
	NONE = 0
	TASK = 1
	IDLETALK = 2
	IDLENEWS = 3
	def initialize
		@@tf = false
		@drawkind = NONE
		@timer_count = 0
		@rstFlag = false
		@init = true
		@init_news = true
		@newsgobis = ["　なのです。", "　ﾅﾉﾃﾞｽ!", "　らしいですよ♪"]
		@devNews = DevNews.new
	end
	attr_accessor :drawkind
	def drawMsg(change = false)
		if @@tf
			glColor3ub(0,0,0)
			case(@drawkind)
			when(IDLETALK)
				drawIdleTalk_task(change)
				glutPostRedisplay
			when(IDLENEWS)
				drawIdleTalk_news(change)
				glutPostRedisplay
			when(TASK)
				drawTasks
				glutPostRedisplay
			end
		end
	end
	def drawIdleTalk_task(change)
		begin
			i = 0
			count = 0
			gobicount = 0
			file = open("data/tasks.txt", "r")
			file.each{count += 1}
			file.rewind	#file pointerを先頭に戻す
			gobifile = open("data/gobis.txt", "r")
			gobifile.each{gobicount += 1}
			gobifile.rewind	#file pointerを先頭に戻す
			if change
				r = rand(count)
				@sentence = file.readlines[r]
				r = rand(gobicount)
				@gobi = gobifile.readlines[r]
			elsif @init
				@sentence = file.gets
				@gobi = gobifile.gets
				@init = false
			end
			@sentence.chomp!
			@sentenceOut = @sentence+@gobi
			@sentenceOut = sentenceSplit(@sentenceOut)
			@sentenceOut.each{|line|
				JPN.kanjidraw($width*0.45,i*20+$height*0.15,line) if @@tf
				i += 1
			}
			file.close
			gobifile.close
		rescue => ex
			p ex
		end
	end
	def drawIdleTalk_news(change)
		begin
			i = 0
			count = 0
			gobicount = 0
			@news = @devNews.getNews
			if change
				r = rand(@news.length)
				@sentence_news = @news[r]
				r = rand(@newsgobis.length)
				@gobi_news = @newsgobis[r]
			elsif @init_news
				@sentence_news = @news[0]
				@gobi_news = @newsgobis[0]
				@init_news = false
			end
			@sentence_news.chomp!
			@sentenceOut_news = '"'+@sentence_news+'"'+@gobi_news
			@sentenceOut_news = sentenceSplit(@sentenceOut_news)
			@sentenceOut_news.each{|line|
				JPN.kanjidraw($width*0.45,i*20+$height*0.15,line) if @@tf
				i += 1
			}
		rescue => ex
			p ex
		end
	end
	def drawTasks()
		begin
			i = 0
			j = 0
			file = open("data/tasks.txt", "r")
			file.each{|sentence|
				sentence.chomp!
				sentence = j.to_s + ". " + sentence
				sentence = sentenceSplit(sentence)
				sentence.each{|line|
					JPN.kanjidraw($width*1/2,i*20,line) if @@tf
					i += 1
				}
				j += 1
			}
			file.close
		rescue => ex
			pp ex
		end
	end
	def sentenceSplit(sentence)
		tmp = NKF.nkf("-sf25",sentence)
		tmp.split(/\n/)
	end
	def timer(piston)
		if @timer_count % 3 == 0
			drawMsg(true)
		end
		if @timer_count > 100
			@timer_count = 0
		end
		@timer_count += 1
	end
	def tf(tf)
		@@tf = tf
		p "tf = #{tf}"
		if(@@tf)
		end
	end
end

class FileSort
	def initialize
	end
	def datesort(filename)
		file = open(filename, "r+")
		file.each{|sentence|
			tmp = sentence.split(/^([0-9]+|[０-９]+)(月|\/)([0-9]+|[０-９]+)(|日)/)

		}
	end
end

class Decoder
	def initialize
		@sys = System.new
		@cha = Chasen.new
		@sort = FileSort.new
	end
	def decode(str)
		str.chomp!
		p str.split(/^(タスク|task|仕事|予定|to do|ToDo|todo|memo|メモ)(　|\s*)/)
		task = str.split(/^(タスク|task|仕事|予定|to do|ToDo|todo|memo|メモ)(　|\s*)/).pop
		taskJudge = str.split(/^(タスク|task|仕事|予定|to do|ToDo|todo|memo|メモ)(　|\s*)/)[1]

		begin
			if task =~ /^del/
				deleteNum = task.split(" ")[1].to_i
				p "deletenum = #{deleteNum}"
				rfile = open("data/tasks.txt", "r")
				i = 0
				save = []
				if deleteNum > 15 || deleteNum < 0
					rfile.close
				else
					while(i < deleteNum)
						save.push(rfile.gets)
						i += 1
					end
					# １行捨てる
					rfile.gets
					while(line = rfile.gets)
						save.push(line)
					end
					rfile.close
				end
				wfile = open("data/tasks.txt", "w")
				save.each{|line|
					wfile.puts(line)
				}
				wfile.close
				glutPostRedisplay
				return
			elsif taskJudge != nil
				file = open("data/tasks.txt", "a")
				file.puts(task)
				file.close
				glutPostRedisplay
				return
			end
		rescue =>ex
			pp ex
			exit
		end
		analData =  @cha.analysis(str)
		pp analData
		analData.each{|word, kana, parse, parseAnal, conjugate, conjuAnal|
			# 全部str型
		}
		exe(str)
		end
		def exe(proname)
			@sys.exe(proname)
		end
		end
