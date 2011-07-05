# ------------------------
# character作成プログラム
# 2010/12/05
# ------------------------

require 'opengl'
require 'devRoom'
require 'devMaid'
require 'devLight'
require 'devObj'
require 'devViewSetting'
require 'devMaidMotion'
require 'devInOut'
include Glut

class DevGlut
	def initialize(xpos=860, ypos=350, width=400, height=400)
		@@xpos = xpos
		@@ypos = ypos
		$width = width
		$height = height
		@viwset = DevViewSetting.new
		@lights = DevLight.new
		@grigri = DevGriAct.new
		@piston = DevPistonAct.new
		@blink = DevBlinkAct.new
		@outp = Output.new
	end

	def display()
		@viwset.backinit
		@lights.enLight
		@room.init
		@room.callRoom
		@room.final
		@maid.init
		@grigri.display
		@piston.display
		@maid.callMaid
		@maid.callMaidBlink(@blink.tf)
		@maid.final
		@lights.disLight
		if @outp.drawkind == Output::IDLETALK || @outp.drawkind == Output::IDLENEWS
			@room.callBoard2
			@outp.drawMsg
		elsif @outp.drawkind == Output::TASK
			@room.callBoard
			@outp.drawMsg
		end
		glutSwapBuffers()
	end

	def reshape(w, h)
		@viwset.reshape(w,h)
		display()
	end

	def idle
		@blink.idle
		@piston.idle
	end

	def keyboard(key, x, y)
		case (key)
			#esc
		when 27
			exit(0)
		when 13
			inp = Input.new(@@xpos, @@ypos, $height)
			inp.inconsole()
		when 'a'[0]
			#a 動きを止める
			if(@piston.getPiston)
				@piston.setPiston(false)
			else
				@piston.setPiston(true)
			end
			glutPostRedisplay
		when 'b'[0]
			#b まばたきストップ
			if(@blink.getBlink)
				@blink.setBlink(false)
			else
				@blink.setBlink(true)
			end
			glutPostRedisplay
		when 's'[0]
			@piston.setPiston(false)
			@blink.setBlink(false)
			@outp.drawkind = Output::NONE
			glutPostRedisplay
		when 't'[0]
			p "t"
			@outp.tf(true)
			@piston.setPiston(false)
			@outp.drawkind = Output::TASK
			@outp.drawMsg
			glutPostRedisplay
		when 'i'[0]
			p "i"
			@outp.tf(true)
			@piston.setPiston(false)
			@outp.drawkind = Output::IDLETALK
			@outp.drawMsg
			glutPostRedisplay
		when 'n'[0]
			p "n"
			@outp.tf(true)
			@piston.setPiston(false)
			@outp.drawkind = Output::IDLENEWS
			@outp.drawMsg
			glutPostRedisplay
		else
		end
	end

	def mouse(button, state, x, y)
		if button == GLUT_LEFT_BUTTON && state == GLUT_DOWN then
			@grigri.startxy(x, y)
		elsif button == GLUT_LEFT_BUTTON && state == GLUT_UP then
		end
	end

	def motion(x, y)
		@grigri.calc(x,y)
		glutPostRedisplay
	end

	def passive(x, y)
	end

	def timer(value)
		@outp.timer(@piston)
		# 1000ms (= 1s)毎
		glutTimerFunc(1000, method(:timer).to_proc(), 0)
	end

	def start()
		glutInit
		glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA | GLUT_DEPTH)
		glutInitWindowSize($width, $height) 
		glutInitWindowPosition(@@xpos, @@ypos)
		glutCreateWindow("Develop Apprication")
		@room = DevRoom.new
		@maid = DevMaid.new
		glutDisplayFunc(method(:display).to_proc()) 
		glutIdleFunc(method(:idle).to_proc())
		glutReshapeFunc(method(:reshape).to_proc())
		glutKeyboardFunc(method(:keyboard).to_proc())
		glutMouseFunc(method(:mouse).to_proc())
		glutMotionFunc(method(:motion).to_proc())
		glutPassiveMotionFunc(method(:passive).to_proc())
		glutTimerFunc(100, method(:timer).to_proc(), 0)
		glutMainLoop()
	end

	def quit()
		@room.quitRoom
		@maid.quitMaid
	end
end

program = DevGlut.new
program.start
