
class DevAnime
	def initialize
		@tvalid = true
	end
end

class DevPistonAct < DevAnime
	TOP = 100
	DTHETA = Math::PI * 0.01
	def initialize
		@@piston = true
		@tvalid = true
		@theta = 0
		@count = 0
	end
	def setPiston(pis)
		@@piston = pis
		p "piston = #{pis}"
	end
	def getPiston
		@@piston
	end
	def idle
		if(@tvalid && @@piston)
			@t = Thread.new{
				@tvalid = false
				@theta += DTHETA
				@count = (@count + 1) % 2
				if @theta >= Math::PI
					@theta -= Math::PI
				end
				glutPostRedisplay
			}
		end
		@tvalid = true if @t.alive? == false
	end
	def display
		glTranslate(0, TOP * Math.sin(@theta), 0)
	end
end

class DevBlinkAct < DevAnime
	BLINKTIME = 0.2
	def initialize
		@@blink = true
		@tvalid = true
	end
	def setBlink(b)
		@@blink = b
	end
	def getBlink
		@@blink
	end
	def idle
		if(@tvalid && @@blink)
			@t = Thread.new{
				@tvalid = false
				r = rand
				if r < 0.10
					@blinkFlag = true
					glutPostRedisplay
					sleep(BLINKTIME)
				else
					@blinkFlag = false
					glutPostRedisplay
					sleep(BLINKTIME)
				end
				glutPostRedisplay
			}
		end
		@tvalid = true if @t.alive? == false
	end
	def tf
		if @blinkFlag
			true
		else
			false
		end
	end
end

class DevGriAct
	def initialize
		@startx = 0
		@starty = 0
		@rotX = 0
		@rotY = 0
	end
	def startxy(x,y)
		@startx = x
		@starty = y
	end
	attr_accessor :rotX
	attr_accessor :rotY
	def calc(x,y)
		dx = x - @startx
		dy = y - @starty
		@rotY += dx
		@rotX += dy
		@startx = x
		@starty = y
	end
	def display
		glRotate( @rotX, 1, 0, 0 )
		glRotate( @rotY, 0, 1, 0 )
	end
end
