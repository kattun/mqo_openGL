
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
		# widthとheightで設定すれば、画面の大きさ変えても大丈夫
		# 透視射影すると、画面サイズを考えるのが面倒
		# gluPerspective(fovy, w/h, znear, zfar);
		glOrtho(-$width, $width, -$height, $height, @znear, @zfar)
		# glLookat(eyeXYZ(座標), 物体XYZ(座標), upXYZ(方向ベクトル)
		gluLookAt(0, 0, 10, 2, 0, -10, 0, 1, 0)
	end

	def backinit
		glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
		glClearColor(*@@backColor)
	end
end
