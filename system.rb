#system programingを担当するクラス群
#にしたい。
#2010/11/16　開始
#

class System
	def initialize()
	end

	def exe(proname)
		viFlag = true
		begin
			dir = Dir::entries("linkProgram")
		rescue => ex
			p ex
		end
		dir.each{|name|
			if proname+".lnk" == name || proname+".lnk" == name 
				system "start linkProgram\\#{proname}.lnk"
				viFlag = false
			end
		}
		system "start linkProgram\\vim.lnk #{proname}" if viFlag
	end
end

