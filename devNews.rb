require 'kconv'
require 'open-uri'
class DevNews
	def initialize
		@news = []
	end
	def getNews

		open('http://news.yahooapis.jp/NewsWebService/V2/topics?appid=rtrqHqGxg666WHR001OkLrciMMlNGPGSiTm_XDFTAoY.MfOGiQzNh4CNDPtPtkeN_DnbFhflbyMM51oUlYQikiiMsA--&pickupcategory=computer'){|f|
			f.each{|line|
				if line =~ /<Title>.*/
					tmp_delTitle = line.gsub(/<Title>/, "").tosjis
					tmp_delTitle = tmp_delTitle.gsub(/<\/Title>/, "").tosjis
					tmp_deltab = tmp_delTitle.gsub(/\t|\n/, "")
					@news.push(tmp_deltab)
				end
			}
		}
		@news
	end
end
