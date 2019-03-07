public class OperTest2 
{
	public static void main(String[] args) 
	{
		int num1 = 13;
		int num2 = 5;
		int num3 = num1 + num2;
		System.out.println(num1 + " + " +num2+ " = " + num3);
		System.out.println(num1 + " + " +num2+ " = " + num1+num2);//+는 순차적으로 계산됨으로 문자열 더하기로 나옴
		System.out.println(num1 + " + " +num2+ " = " + (num1+num2)); //()를 붙여서 먼저 계산해야함

		num3 = num1 - num2;
		System.out.println(num1 + " - " +num2+ " = " + num3);
		System.out.println(num1 + " + " +num2+ " = " + (num1-num2));//-는 ()없으면 오류남

		num3 = num1 * num2;
		System.out.println(num1 + " * " +num2+ " = " + num3);
		System.out.println(num1 + " + " +num2+ " = " + num1*num2); //*,/,%는 먼저 계산되기 때문에 () 없어도 됨

		num3 = num1 / num2;
		System.out.println(num1 + " / " +num2+ " = " + num3);
		System.out.println(num1 + " + " +num2+ " = " + num1/num2);

		num3 = num1 % num2;
		System.out.println(num1 + " % " +num2+ " = " + num3);
		System.out.println(num1 + " + " +num2+ " = " + num1%num2);

	}
}
