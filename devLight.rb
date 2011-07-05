require 'opengl'
include Gl
class DevLight
	def initialize()
		@diffuse  = [ 0.9, 0.9, 0.9, 1.0 ]	# 拡散反射光
		@specular = [ 1.0, 1.0, 1.0, 1.0 ]	# 鏡面反射光
		@ambient  = [ 0.3, 0.3, 0.3, 0.1 ]	# 環境光
		@position = [ 0.0, 10.0, -30.0, 1.0 ]	# 位置と種類
	end

	attr_accessor :diffuse
	attr_accessor :specular
	attr_accessor :ambient
	attr_accessor :position

	def enLight()
		# 光源の設定
		glLightfv( GL_LIGHT0, GL_DIFFUSE,  @diffuse )	 # 拡散反射光の設定
		glLightfv( GL_LIGHT0, GL_SPECULAR, @specular ) # 鏡面反射光の設定
		glLightfv( GL_LIGHT0, GL_AMBIENT,  @ambient )	 # 環境光の設定
		glLightfv( GL_LIGHT0, GL_POSITION, @position ) # 位置と種類の設定

		glShadeModel( GL_SMOOTH )	# シェーディングの種類の設定
		glEnable( GL_LIGHT0 )		# 光源の有効化
		glEnable( GL_DEPTH_TEST )
		glEnable( GL_LIGHTING )
	end

	def disLight()
		glDisable( GL_LIGHT0 )
		glDisable( GL_LIGHTING )
		glDisable( GL_DEPTH_TEST )
	end
end
