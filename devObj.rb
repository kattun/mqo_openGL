require 'opengl'
require 'glmetaseqo'
include Gl

class DevObj
	def initialize()
	end

	def init()
		glMatrixMode(GL_MODELVIEW)
		glPushMatrix()
		glTranslate(100.0, -400.0, -700.0)
	end

	def final()
		glPopMatrix()
	end
end
