import java.util.Scanner;

class NegativeAmountException extends Exception {
   public NegativeAmountException(String message) {
        super(message);
    }
}

public class UserDefinedExceptionExample {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        double amount = 0;
        boolean validInput = false;

    while (!validInput) {
        System.out.print("Enter an amount: ");
            if (scanner.hasNextDouble()) {
                amount = scanner.nextDouble();
                try {
                    if (amount < 0) {
                        throw new NegativeAmountException("Amount cannot be negative: " + amount);
                    }
                    validInput = true; // Input is valid and no exception thrown
                } catch (NegativeAmountException e) {
                    System.out.println("Error: " + e.getMessage());
                }
            } else {
                System.out.println("Invalid input. Please enter a numeric value.");
                scanner.next(); // Consume invalid input
            }
        }

        System.out.println("Amount entered: " + amount);
        scanner.close();
        System.out.println("End of program.");
    }
}