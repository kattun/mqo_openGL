require 'opengl'
include Gl
class DevLight
	def initialize()
		@diffuse  = [ 0.9, 0.9, 0.9, 1.0 ]	# �g�U���ˌ�
		@specular = [ 1.0, 1.0, 1.0, 1.0 ]	# ���ʔ��ˌ�
		@ambient  = [ 0.3, 0.3, 0.3, 0.1 ]	# ����
		@position = [ 0.0, 10.0, -30.0, 1.0 ]	# �ʒu�Ǝ��
	end

	attr_accessor :diffuse
	attr_accessor :specular
	attr_accessor :ambient
	attr_accessor :position

	def enLight()
		# �����̐ݒ�
		glLightfv( GL_LIGHT0, GL_DIFFUSE,  @diffuse )	 # �g�U���ˌ��̐ݒ�
		glLightfv( GL_LIGHT0, GL_SPECULAR, @specular ) # ���ʔ��ˌ��̐ݒ�
		glLightfv( GL_LIGHT0, GL_AMBIENT,  @ambient )	 # �����̐ݒ�
		glLightfv( GL_LIGHT0, GL_POSITION, @position ) # �ʒu�Ǝ�ނ̐ݒ�

		glShadeModel( GL_SMOOTH )	# �V�F�[�f�B���O�̎�ނ̐ݒ�
		glEnable( GL_LIGHT0 )		# �����̗L����
		glEnable( GL_DEPTH_TEST )
		glEnable( GL_LIGHTING )
	end

	def disLight()
		glDisable( GL_LIGHT0 )
		glDisable( GL_LIGHTING )
		glDisable( GL_DEPTH_TEST )
	end
end
