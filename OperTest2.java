public class OperTest2 
{
	public static void main(String[] args) 
	{
		int num1 = 13;
		int num2 = 5;
		int num3 = num1 + num2;
		System.out.println(num1 + " + " +num2+ " = " + num3);
		System.out.println(num1 + " + " +num2+ " = " + num1+num2);//+�� ���������� �������� ���ڿ� ���ϱ�� ����
		System.out.println(num1 + " + " +num2+ " = " + (num1+num2)); //()�� �ٿ��� ���� ����ؾ���

		num3 = num1 - num2;
		System.out.println(num1 + " - " +num2+ " = " + num3);
		System.out.println(num1 + " + " +num2+ " = " + (num1-num2));//-�� ()������ ������

		num3 = num1 * num2;
		System.out.println(num1 + " * " +num2+ " = " + num3);
		System.out.println(num1 + " + " +num2+ " = " + num1*num2); //*,/,%�� ���� ���Ǳ� ������ () ��� ��

		num3 = num1 / num2;
		System.out.println(num1 + " / " +num2+ " = " + num3);
		System.out.println(num1 + " + " +num2+ " = " + num1/num2);

		num3 = num1 % num2;
		System.out.println(num1 + " % " +num2+ " = " + num3);
		System.out.println(num1 + " + " +num2+ " = " + num1%num2);

	}
}
