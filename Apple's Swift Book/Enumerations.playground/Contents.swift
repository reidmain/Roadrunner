/*
Code generated while going through the 'Enumerations' chapter of Apple's Swift book.
*/

enum Barcode
{
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}

var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)
productBarcode.dynamicType
productBarcode = .QRCode("ABCDEFGHIJKLMNOP")
productBarcode.dynamicType

switch productBarcode
{
	case .UPCA(let numberSystem, let manufacturer, let product, let check):
		print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
	case .QRCode(let productCode):
		print("QR code: \(productCode).")
}

enum ASCIIControlCharacter : Character
{
	case Tab = "\t"
	case LineFeed = "\n"
	case CarriageReturn = "\r"
}

enum CompassPoint : String
{
    case North
	case South
	case East
	case West
}
CompassPoint.East.rawValue

indirect enum ArithmeticExpression
{
    case Number(Int)
    case Addition(ArithmeticExpression, ArithmeticExpression)
    case Multiplication(ArithmeticExpression, ArithmeticExpression)
}

func evaluate(expression: ArithmeticExpression) -> Int
{
    switch expression
	{
		case let .Number(value):
			return value
		case let .Addition(left, right):
			return evaluate(left) + evaluate(right)
		case let .Multiplication(left, right):
			return evaluate(left) * evaluate(right)
    }
}

let five = ArithmeticExpression.Number(5)
let four = ArithmeticExpression.Number(4)
let sum = ArithmeticExpression.Addition(five, four)
let product = ArithmeticExpression.Multiplication(sum, ArithmeticExpression.Number(2))
evaluate(product)