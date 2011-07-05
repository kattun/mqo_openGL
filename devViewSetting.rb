
class DevViewSetting
	def initialize()
		@znear = 1
		@zfar = 10000
		@@backColor = [0.0, 0.0, 0.8, 1.0]
	end

	def reshape(w,h)
		$width = w
		$height = h
		glViewport(0, 0, $width, $height)
		glMatrixMode(GL_PROJECTION)
		glLoadIdentity()
		# width��height�Őݒ肷��΁A��ʂ̑傫���ς��Ă����v
		# �����ˉe����ƁA��ʃT�C�Y���l����̂��ʓ|
		# gluPerspective(fovy, w/h, znear, zfar);
		glOrtho(-$width, $width, -$height, $height, @znear, @zfar)
		# glLookat(eyeXYZ(���W), ����XYZ(���W), upXYZ(�����x�N�g��)
		gluLookAt(0, 0, 10, 2, 0, -10, 0, 1, 0)
	end

	def backinit
		glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
		glClearColor(*@@backColor)
	end
end
