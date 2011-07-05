require 'dl'
require 'dl/import'

class Chasen
	def initialize
		@LIB = DL.dlopen('dll/libchasen.dll')
		@SYM ={
			:chasen_sparse_tostr => @LIB['chasen_sparse_tostr', 'SS'], 
			:chasen_getopt_argv => @LIB['chasen_getopt_argv', 'IPP']
		}
	end
	def analysis(str)
		r, rs = @SYM[:chasen_sparse_tostr].call(str)
		rsp = r.split(/\n/)
		r = []
		rsp.each{|item|
			r.push(item.split(/\t/))
		}
		r
	end
	# �I�v�V�����g�����͕s�������ǈꉞ�c���Ă���
	def chasen_getopt_argv(argv, fp)
		r,rs = @SYM[:chasen_getopt_argv].call(argv, fp)
		p rs
		return r
	end
end
