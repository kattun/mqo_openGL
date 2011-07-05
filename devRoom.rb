require 'devObj'
class DevRoom < DevObj
	def initialize
		super
		@room = DL::PtrData.malloc(4)
		@board = DL::PtrData.malloc(4)
		@board2 = DL::PtrData.malloc(4)

		GLM.mqoInit()
		@room = GLM.mqoCreateModel("mqo_model/room/room.mqo",1.0)
		@board = GLM.mqoCreateModel("mqo_model/room/board.mqo",1.0)
		@board2 = GLM.mqoCreateModel("mqo_model/room/board2.mqo",1.0)
	end
	def callRoom()
		glRotate( 30, 1, -1, 0)
		GLM.mqoCallModel(@room)
	end
	def callBoard()
		GLM.mqoCallModel(@board)
	end
	def callBoard2()
		GLM.mqoCallModel(@board2)
	end
	def quitRoom()
		GLM.mqoDeleteModel( @room )
	end
end
