require 'devObj'
class DevMaid < DevObj
	def initialize
		super
		@face = DL::PtrData.malloc(4)
		@blink = DL::PtrData.malloc(4)
		@body = DL::PtrData.malloc(4)
		@rightarm = DL::PtrData.malloc(4)
		@leftarm = DL::PtrData.malloc(4)
		@rightleg = DL::PtrData.malloc(4)
		@leftleg = DL::PtrData.malloc(4)

		GLM.mqoInit()
		@face = GLM.mqoCreateModel("mqo_model/maid/maid_face.mqo",1.0)
		@blink = GLM.mqoCreateModel("mqo_model/maid/maid_face_blink.mqo",1.0)
		@body = GLM.mqoCreateModel("mqo_model/maid/maid_body.mqo",1.0)
		@rightarm = GLM.mqoCreateModel("mqo_model/maid/maid_rightarm.mqo",1.0)
		@leftarm = GLM.mqoCreateModel("mqo_model/maid/maid_leftarm.mqo",1.0)
		@rightleg = GLM.mqoCreateModel("mqo_model/maid/maid_rightleg.mqo",1.0)
		@leftleg = GLM.mqoCreateModel("mqo_model/maid/maid_leftleg.mqo",1.0)
	end
	def callMaid()
		glTranslate(-200,0,0)
		glScale(1.2,1.2,1.2)
		GLM.mqoCallModel(@face)
		GLM.mqoCallModel(@body)
		GLM.mqoCallModel(@rightarm)
		GLM.mqoCallModel(@leftarm)
		GLM.mqoCallModel(@rightleg)
		GLM.mqoCallModel(@leftleg)
	end

	def callMaidBlink(tf)
		# CallModel‚µ‚Ä‚È‚¢‚Æ•`‰æ‚³‚ê‚È‚¢
		# delete‚·‚é•K—v‚Í‚È‚¢
		GLM.mqoCallModel(@blink) if tf
	end

	def quitMaid()
		GLM.mqoDeleteModel( @face )
		GLM.mqoDeleteModel( @blink )
		GLM.mqoDeleteModel( @body )
		GLM.mqoDeleteModel( @rightarm )
		GLM.mqoDeleteModel( @leftarm )
		GLM.mqoDeleteModel( @rightleg )
		GLM.mqoDeleteModel( @leftleg )
	end
end
