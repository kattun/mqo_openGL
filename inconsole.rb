require 'vr/vruby'
require 'vr/vrcontrol'
require 'vr/vrhandler'

class InConSole < VRForm
	include VRKeyFeasible
	include VRFocusSensitive
	include VRDestroySensitive

	def initialize
		@dec = Decoder.new
		@ret_flag = false
	end
	def construct
		addControl(VRText, "edt", nil, 0, 0, $width, 50, WStyle::WS_BORDER)
	end
	def self_created
		@edt.focus
	end
	def self_gotfocus
		if @ret_flag
			@ret_flag = false
			@dec.decode(@edt.text)
			close
		end
	end
	def self_lostfocus
	end
	def self_destroy
	end
	def self_char(keycode, keydata)
		case keycode
		when 27 then
			close
		else
			@edt.text += keycode.chr
		end
	end
	def edt_changed
		p @edt.text
		if @edt.text[/\n/] then
			@ret_flag = true
			focus
		end
	end
end
class InputUse
	def initialize(xpos, ypos, height)
		@console = VRLocalScreen.newform(nil,WStyle::WS_BORDER, InConSole)
		@console.move(xpos, ypos + height*0.8, 600, 80)
		@console.caption = "input"
		@console.create.show
		@sys = System.new
	end

	def stdinconsole()
		VRLocalScreen.messageloop
	end

	def exe(proname)
		@sys.exe(proname)
	end
end
