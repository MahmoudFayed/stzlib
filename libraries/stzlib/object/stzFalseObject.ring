


func StzFalseObjectQ()
	return new stzFalseObject

	func FalseObject()
		return new stzFalseObject

	func AFalseObject()
		return new stzFalseObject

	func False()
		return new stzFalseObject

	func FalseQ()
		return new stzFalseObject

	func StzFalseQ()
		return new stzFalseObject

#< @ClassMisspelledForms

class stzFalsObject from stzFalseObject
class stzFlaseObject from stzFalseObject

#>

class stzFalse from stzFalseObject

class stzFalseObject from stzObject
	@cVarName = :@falseobject

	def Content()
		return FALSE

		def Value()
			return Content()

	def StzType()
		return :stzFalseObject

	#--

	def Where(pcCondition)
		return FALSE

		def W(pcCondition)
			return FALSE

	#--

	def IsEqualToCS(p, pCaseSensitive)
		return FALSE

		#< @FunctionFluentForm

		def IsEqualToCSQ(p, pCaseSensitie)
			return This

		#>

		#< @FunctionAlternativeForms

		def EqualToCS(p, pCaseSensitive)
			return FALSE

			def EqualToCSQ(p, pCaseSensitive)
				return This

		def EqualsCS(p, pCaseSensitive)
			return FALSE

			def EqualCSQ(p, pCaseSensitive)
				return This

		#>

	#-- WITHOUT CASESENSITIVITY

	def IsEqualTo(p)
		return FALSE

		#< @FunctionFluentForm

		def IsEqualToQ(p)
			return This

		#>

		#< @FunctionAlternativeForms

		def EqualTo(p)
			return FALSE

			def EqualToQ(p)
				return This

		def Equals(p)
			return FALSE

			def EqualQ(p)
				return This

		#>

	def IsDividableBy(n)
		return FALSE

		def IsDividableByQ(n)
			return This

		def DividableBy(n)
			return FALSE

			def DividableByQ(n)
				return This

		def IsDivisibleBy(n)
			return FALSE

			def IsDivisibleByQ()
				return This

		def DivisibleBy(n)
			return FALSE

			def DivisibleByQ(n)
				return This
